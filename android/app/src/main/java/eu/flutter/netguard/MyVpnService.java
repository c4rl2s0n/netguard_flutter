package eu.flutter.netguard;

import android.app.ForegroundServiceStartNotAllowedException;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.net.ConnectivityManager;
import android.net.LinkProperties;
import android.net.Network;
import android.net.VpnService;
import android.os.Build;
import android.os.Bundle;
import android.os.Looper;
import android.os.ParcelFileDescriptor;
import android.os.Process;

import androidx.core.content.ContextCompat;
import androidx.preference.PreferenceManager;

import java.net.InetAddress;
import java.net.InetSocketAddress;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.locks.ReentrantReadWriteLock;

import eu.flutter.netguard.data.DatabaseHelper;
import eu.flutter.netguard.data.IPKey;
import eu.flutter.netguard.data.ModelBuilder;
import eu.flutter.netguard.data.PersistenceCache;
import eu.flutter.netguard.network.NetworkMonitor;
import eu.flutter.netguard.network.NetworkUtils;
import eu.flutter.netguard.network.Protocols;
import eu.flutter.netguard.utils.*;
import eu.flutter.netguard.flutter.NativeBridge.*;

public class MyVpnService extends VpnService {
    static final String TAG = "NetGuard.VPNService";

    static {
        try {
            System.loadLibrary("netguard");
        } catch (UnsatisfiedLinkError ignored) {
            System.exit(1);
        }
    }

    private static final Object jni_lock = new Object();
    private static long jni_context = 0;
    private native long jni_init(int sdk);
    private native void jni_start(long context, int loglevel);
    private native void jni_run(long context, int tun, boolean logTraffic, boolean observeOnly);
    private native void jni_stop(long context);
    private native void jni_clear(long context);
    private native int jni_get_mtu();
    private native int[] jni_get_stats(long context);
    private native void jni_socks5(String addr, int port, String username, String password);
    private native void jni_done(long context);

    private Thread tunnelThread = null;
    private final ReentrantReadWriteLock lock = new ReentrantReadWriteLock(true);

    private ParcelFileDescriptor vpnInterface;
    private static VpnConfig vpnConfig;

    NetworkMonitor networkMonitor;
    private LogHandler logHandler;
    private NotificationTools notification;

    private final Map<String, Boolean> mapGlobalBlockedHosts = new HashMap<>();
    private final Map<String, Boolean> mapGlobalBlockedIPs = new HashMap<>();
    private final Map<Long, List<Rule>> mapUidRules = new HashMap<>();
    private final Set<Long> setUidBlockAll = new HashSet<>();
    private final Set<Long> setUidBlockQuic = new HashSet<>();
    private final Map<Long, String> mapUidPackageName = new HashMap<>();
    private final Map<IPKey, Long> mapIPKeyUid = new HashMap<>();
    private final Map<IPKey, String> mapIPKeySni = new HashMap<>();
    private final Map<String, String> mapIpUidDomain = new HashMap<>();

    private List<ApplicationSetting> applicationSettings;

    private static DatabaseHelper database;

    public static boolean isRunning(Context context) {
        return PersistenceCache.VpnServiceRunning(PreferenceManager.getDefaultSharedPreferences(context));
    }
    public static VpnConfig getSessionConfig(Context context) {
        if(isRunning(context)) return vpnConfig;
        return null;
    }
    private void SetIsRunning(boolean isRunning){
        var sharedPrefs = PreferenceManager.getDefaultSharedPreferences(this);
        PersistenceCache.SetVpnServiceRunning(sharedPrefs, isRunning);
        if(vpnConfig != null) {
            vpnConfig.setFinished(!isRunning);
            PersistenceCache.SetVpnConfig(sharedPrefs, vpnConfig);
        }
    }

    public static void reload(Context context, String reason) {
        if (!isRunning(context)) return;
        Log.i(TAG, "Reload VPN - "+reason);
        Intent intent = new Intent(context, MyVpnService.class);
        intent.setAction(Values.Intent.Actions.RELOAD);
        try {
            ContextCompat.startForegroundService(context, intent);
        } catch (Throwable ex) {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S &&
                    ex instanceof ForegroundServiceStartNotAllowedException) {
                try {
                    context.startService(intent);
                } catch (Throwable exex) {
                    Log.e(TAG, exex + "\n" + Log.getStackTraceString(exex));
                }
            }
        }
    }

    @Override
    public void onCreate() {
        Log.i(TAG, "Create version=" + Util.getSelfVersionName(this) + "/" + Util.getSelfVersionCode(this));

        notification = new NotificationTools(this);
        startForeground(NotificationTools.WAITING, notification.getWaitingNotification());

        networkMonitor = new NetworkMonitor(this);
        logHandler = new LogHandler(this, Looper.getMainLooper());

        if (jni_context != 0) {
            Log.w(TAG, "Create with context=" + jni_context);
            jni_stop(jni_context);
            synchronized (jni_lock) {
                jni_done(jni_context);
                jni_context = 0;
            }
        }

        // Native init
        jni_context = jni_init(Build.VERSION.SDK_INT);
        Log.i(TAG, "Created context=" + jni_context);

        super.onCreate();

        /// TODO: Maybe register some of these listeners from SinkholeService.onCreate
        ///  i.e. idleState, connectivity, alarmManager, ... (?)
    }
    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        if (intent == null) return START_STICKY;
        Log.i(TAG, "onStartCommand...");

        String action = intent.getAction();
        if(action == null) action = "";

        Log.i(TAG, "onStartCommand: "+action);

        switch (action) {
            case Values.Intent.Actions.START:
                if(isRunning(this))
                    reloadVpn();
                else
                    startVpn();
                break;
            case Values.Intent.Actions.RELOAD:
                reloadVpn();
                break;
            case Values.Intent.Actions.STOP:
                stopVpn();
                break;
            case Values.Intent.Actions.PUSH_STATS:
                Bundle bundle = intent.getExtras();
                if(bundle != null) {
                    SessionStatistics sessionStatistics = ModelBuilder.SessionStatisticsFromBundle(bundle);
                    updateStatsNotification(sessionStatistics);
                }
                break;
        }

        return START_STICKY;
    }

    public static void updateVpnConfig(Context context, VpnConfig config){
        if(config == null) return;

        MyVpnService.vpnConfig = config;
        PersistenceCache.SetVpnConfig(PreferenceManager.getDefaultSharedPreferences(context), config);

        // TODO: check if this should be done here...
        if(false && isRunning(context)){
            reload(context, "Update Config");
        }
    }

    void updateStatsNotification(SessionStatistics sessionStatistics){
        notification.updateStatsNotification(sessionStatistics);
    }
    private void startVpn(){
        if (vpnInterface != null) return;

        startForeground(NotificationTools.WAITING, notification.getRunningNotification());
        Log.i(TAG, "Starting the VPN!");

        // load config from shared preferences
        vpnConfig = PersistenceCache.VpnConfig(PreferenceManager.getDefaultSharedPreferences(this));

        Log.setLogLevel(vpnConfig.getLogLevel().intValue());

        database = new DatabaseHelper(Values.Paths.database(this));

        applicationSettings = database.getApplicationSettings(vpnConfig.getFilteredPackages());
        // Keep awake
        WakeLock.getLock(this).acquire();

        networkMonitor.openListener();

        Builder builder = getBuilder(vpnConfig.getFilteredPackages());

        try {
            vpnInterface = builder.establish();
            if (vpnInterface == null) {
                Log.e(TAG, "Failed to establish VPN interface");
            } else {
                Log.i(TAG, "VPN interface established");
                SetIsRunning(true);
                logHandler.vpnStarted();
                startNative(vpnInterface);
                return;
            }
        } catch (Exception e) {
            Log.e(TAG, "Failed to start VPN", e);
        }
        SetIsRunning(false);
    }
    private void reloadVpn(){
        Log.i(TAG, "Restarting VPN");
        if(isRunning(this)) stopVpn();
        startVpn();
    }
    private void stopVpn(){
        stopNative();
        if(database != null) database.close();
        if (vpnInterface != null) {
            try {
                vpnInterface.close();
                SetIsRunning(false);
            } catch (Exception ignored) {}
            vpnInterface = null;
        }

        networkMonitor.closeListener();

        stopForeground(true);
        notification.hideStatsNotification();

        // release WakeLock
        WakeLock.releaseLock(this);

        logHandler.vpnStopped();
        Log.i(TAG, "VPN stopped");
        SetIsRunning(false);
    }

    @Override
    public void onDestroy() {
        Log.i(TAG, "VPN stopping...");

        stopVpn();

        super.onDestroy();
    }


    private Builder getBuilder(List<String> packageNames) {
        // Build VPN service
        Builder builder = new Builder();
        builder.setSession("NetGuard");

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q)
            builder.setMetered(NetworkUtils.isMeteredNetwork(this));

        // VPN address
        String vpn4 = "10.1.10.1"; //prefs.getString("vpn4", "10.1.10.1");
        Log.i(TAG, "Using VPN4=" + vpn4);
        builder.addAddress(vpn4, 32);
        String vpn6 = "fd00:1:fd00:1:fd00:1:fd00:1"; // prefs.getString("vpn6", "fd00:1:fd00:1:fd00:1:fd00:1");
        Log.i(TAG, "Using VPN6=" + vpn6);
        builder.addAddress(vpn6, 128);

        // DNS address
        // TODO: custom DNS servers
        for (InetAddress dns : NetworkUtils.getDefaultDns(MyVpnService.this)) {
            Log.i(TAG, "Using DNS=" + dns);
            builder.addDnsServer(dns);
        }

        // TODO: what is this?!
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M)
            try {
                ConnectivityManager cm = (ConnectivityManager) getSystemService(Context.CONNECTIVITY_SERVICE);
                Network active = (cm == null ? null : cm.getActiveNetwork());
                LinkProperties props = (active == null ? null : cm.getLinkProperties(active));
                String domain = (props == null ? null : props.getDomains());
                if (domain != null) {
                    Log.i(TAG, "Using search domain=" + domain);
                    builder.addSearchDomain(domain);
                }
            } catch (Throwable ex) {
                Log.e(TAG, ex + "\n" + Log.getStackTraceString(ex));
            }

        // TODO: Subnet routing needed? See NetGuard
        builder.addRoute("0.0.0.0", 0);
        builder.addRoute("::", 0); // unicast
        // builder.addRoute("2000::", 3); // unicast

        // MTU
        int mtu = jni_get_mtu();
        Log.i(TAG, "MTU=" + mtu);
        builder.setMtu(mtu);


        // Add list of routed applications
        if(packageNames.isEmpty()){
            // if no filtered packages are specified, add the firewall itself
            try {
                builder.addAllowedApplication(getPackageName());
            } catch (PackageManager.NameNotFoundException ex) {
                Log.e(TAG, ex + "\n" + Log.getStackTraceString(ex));
            }
        }else {
            // Whitelist
            for (var packageName : packageNames) {
                try {
                    builder.addAllowedApplication(packageName);
                    Log.i(TAG, "MyVpnService " + packageName);
                } catch (PackageManager.NameNotFoundException ex) {
                    Log.e(TAG, ex + "\n" + Log.getStackTraceString(ex));
                }
            }
        }

        return builder;
    }

    private void startNative(final ParcelFileDescriptor vpn) {
        prepareCacheMaps();
        prepareGlobalRules();
        preparePackageRules();
        prepareApplicationSettings();

        int prio = vpnConfig.getLogLevel().intValue();

        if (tunnelThread == null) {
            Log.i(TAG, "Starting tunnel thread context=" + jni_context);
            jni_start(jni_context, prio);

            tunnelThread = new Thread(new Runnable() {
                @Override
                public void run() {
                    Log.i(TAG, "Running tunnel context=" + jni_context);
                    jni_run(jni_context,
                            vpn.getFd(),
                            vpnConfig.getLogTraffic(),
                            vpnConfig.getObserveOnly());
                    Log.i(TAG, "Tunnel exited");
                    tunnelThread = null;
                }
            });
            //tunnelThread.setPriority(Thread.MAX_PRIORITY);
            tunnelThread.start();

            Log.i(TAG, "Started tunnel thread");
        }

    }

    private void stopNative() {
        Log.i(TAG, "Stop native");

        if (tunnelThread != null) {
            Log.i(TAG, "Stopping tunnel thread");

            jni_stop(jni_context);

            Thread thread = tunnelThread;
            while (thread != null && thread.isAlive()) {
                try {
                    Log.i(TAG, "Joining tunnel thread context=" + jni_context);
                    thread.join();
                } catch (InterruptedException ignored) {
                    Log.i(TAG, "Joined tunnel interrupted");
                }
                thread = tunnelThread;
            }
            tunnelThread = null;

            jni_clear(jni_context);

            Log.i(TAG, "Stopped tunnel thread");
        }
    }


    private void prepareGlobalRules() {
        mapGlobalBlockedHosts.clear();
        mapGlobalBlockedIPs.clear();
    }
    private void prepareCacheMaps() {
        mapIPKeyUid.clear();
        mapIPKeySni.clear();
        mapIpUidDomain.clear();
    }
    private void preparePackageRules() {
        lock.writeLock().lock();
        mapUidRules.clear();
        mapUidPackageName.clear();
        for(var applicationSetting : applicationSettings){
            String packageName = applicationSetting.getPackageName();
            if(!vpnConfig.getFilteredPackages().contains(packageName)) continue;

            // lookup the uid of a packageName
            long uid = Util.packageNameToUid(this, packageName);
            if(uid < 0) continue;
            mapUidPackageName.put(uid, packageName);


            // check if a rule is available for the package
            List<Rule> rules = database.getPackageRule(packageName);
            if(rules == null || rules.isEmpty()) continue;

            mapUidRules.put(uid, rules);
        }

        lock.writeLock().unlock();
    }
    private void prepareApplicationSettings() {
        setUidBlockAll.clear();
        setUidBlockQuic.clear();
        for(var applicationSetting : applicationSettings){
            String packageName = applicationSetting.getPackageName();
            if(!vpnConfig.getFilteredPackages().contains(packageName)) continue;

            long uid = Util.packageNameToUid(this, packageName);
            if(uid < 0) continue;
            if(applicationSetting.getBlockAll()) setUidBlockAll.add(uid);
            if(applicationSetting.getBlockQuic()) setUidBlockQuic.add(uid);
        }
    }


    ///  ERROR HANDLING (TODO)
    // Called from native code
    private void nativeExit(String reason) {
        Log.w(TAG, "Native exit reason=" + reason);
        if (reason != null) {
            // TODO: showErrorNotification(reason);
            logHandler.logError("[NATIVE EXIT]", reason, null);
        }
    }

    // Called from native code
    private void nativeError(int error, String message) {
        Log.w(TAG, "Native error " + error + ": " + message);

    }

    ///  TRAFFIC LOGGING
    // Called from native code
    private void logTraffic(long time, int version, int protocol, String saddr, int sport, String daddr, int dport, long length, long uid, boolean allowed, boolean outgoing) {
        // try to lookup uid from logged IPKeys
        if(uid <= 0) uid = getUidCached(version, protocol, saddr, sport, daddr, dport);

        // log the traffic if it does not come from firewall itself (should not happen though...)
        if (uid != Process.myUid()) {
            IPKey key = new IPKey(version, protocol, saddr, sport, daddr, dport, uid);
            String packageName = mapUidPackageName.get(uid);
            String domain = getDomainName(key);

            TrafficLog log = ModelBuilder.TrafficLog(time, vpnConfig.getSession(), packageName, protocol, daddr, domain, dport, length, allowed, outgoing);
            logHandler.traffic(log);
        }
    }

    ///  CACHE DOMAIN NAMES
    // Called from native code
    private void dnsResolved(ResourceRecord rr) {
        Log.wtf(TAG, "DnsResolved uid="+rr.getUid());
        Long uid = rr.getUid();
        if(uid == null){
            uid = (long) -1;
        }
        String key = getMapIpUidDomainKey(rr.getResource(), uid);
        mapIpUidDomain.put(key, NetworkUtils.cleanDomain(rr.getQName()));

        // also log the domain for the unknown uid as a fallback
        key = getMapIpUidDomainKey(rr.getResource(), -1);
        mapIpUidDomain.put(key, NetworkUtils.cleanDomain(rr.getQName()));
    }
    private void sniResolved(String sni, int version, int protocol, String saddr, int sport, String daddr, int dport, int uid) {
        IPKey key = new IPKey(version, protocol, saddr, sport, daddr, dport, uid);
        sni = NetworkUtils.cleanDomain(sni);
        mapIPKeySni.put(key, sni);
    }


    ///  LOOKUP AND CACHE UIDs
    // Called from native code
    @androidx.annotation.RequiresApi(Build.VERSION_CODES.Q)
    private int getUidQ(int version, int protocol, String saddr, int sport, String daddr, int dport) {
        if (protocol != Protocols.TCP && protocol != Protocols.UDP)
            return Process.INVALID_UID;

        ConnectivityManager cm = (ConnectivityManager) getSystemService(CONNECTIVITY_SERVICE);
        if (cm == null)
            return Process.INVALID_UID;

        InetSocketAddress local = new InetSocketAddress(saddr, sport);
        InetSocketAddress remote = new InetSocketAddress(daddr, dport);

        int uid = cm.getConnectionOwnerUid(protocol, local, remote);
        Log.i(TAG, "Get uid local=" + local + " remote=" + remote + " uid="+uid);
        return uid;
    }

    private int getUidCached(int version, int protocol, String saddr, int sport, String daddr, int dport) {
        int uid = -1;
        var key = new IPKey(version, protocol, saddr, sport, daddr, dport, -1);
        if(mapIPKeyUid.containsKey(key)){
            Long lUid = mapIPKeyUid.get(key);
            assert lUid != null;
            uid = lUid.intValue();
            Log.i(TAG, "Get uid cached: local=" + saddr + " sport=" + sport + " remote=" + daddr + " dport=" + dport + " uid="+uid);
        }
        return uid;
    }
    private void cacheUid(int version, int protocol, String saddr, int sport, String daddr, int dport, int uid) {
        var key = new IPKey(version, protocol, saddr, sport, daddr, dport, -1);
        mapIPKeyUid.put(key, (long) uid);
    }

    ///  CHECK FIREWALL RULES
    // Called from native code
    private boolean isQuicBlocked(int uid) {
        return setUidBlockQuic.contains((long)uid);
    }
    private boolean isDomainBlocked(int uid, String name) {
        lock.readLock().lock();

        // remove eventually leading 'www.'
        name = NetworkUtils.cleanDomain(name);

        // check if the uid is fully blocked
        boolean blocked = setUidBlockAll.contains((long) uid);

        // if not, check if the domain is blocked for the given application
        if(!blocked && uid > 0){
            RuleCheckResult result = blockedByRule(uid, name, CheckRuleTarget.host);
            blocked = result.blocked;
            if(result.checkFinished){
                lock.readLock().unlock();
                return blocked;
            }
        }

        // else, check if the domain is blocked globally
        if(!blocked) {
            blocked = hostBlockedGlobally(name);
        }

        lock.readLock().unlock();
        return blocked;
    }
    private boolean isAddressAllowed(int version, int protocol, String saddr, int sport, String daddr, int dport, long uid) {
        lock.readLock().lock();
        boolean allowed;

        if(setUidBlockAll.contains(uid)) {
            // check if the uid is fully blocked
            allowed = false;
        } else if (uid == android.os.Process.myUid()) {
            // Allow self
            allowed = true;
            // Log.w(TAG, "Allowing self " + packet);
        } else {
            // check if IP is blocked for given package
            RuleCheckResult result = blockedByRule(uid, daddr, CheckRuleTarget.ip);
            boolean blocked = result.blocked;
            if(result.checkFinished){
                lock.readLock().unlock();
                return blocked;
            }

            // lookup domain and check if that might be blocked
            String domain = null;
            if(!blocked) domain = getDomainName(new IPKey(version, protocol, saddr, sport, daddr, dport, uid));
            if(domain != null && !domain.isBlank()){
                blocked = isDomainBlocked((int)uid, domain);
            }

            // if the ip is not yet blocked, we check the global hosts-file
            if(!blocked) {
                blocked = ipBlockedGlobally(daddr);
            }

            allowed = !blocked;
        }

        lock.readLock().unlock();

        return allowed;
    }

    private boolean hostBlockedGlobally(String host){
        // host is already cached?
        if(mapGlobalBlockedIPs.containsKey(host)){
            // check if host is globally blocked
            return Boolean.TRUE.equals(mapGlobalBlockedHosts.get(host));
        } else {
            // otherwise, lookup the host in the database; store it in the lookup table for future lookups
            if (database.genericBlacklistContainsHost(host)) {
                mapGlobalBlockedHosts.put(host, true);
                return true;
            } else {
                mapGlobalBlockedHosts.put(host, false);
                return false;
            }
        }
    }
    private boolean ipBlockedGlobally(String ip){
        // IP is already cached?
        if(mapGlobalBlockedIPs.containsKey(ip)){
            // check if IP is globally blocked
            return Boolean.TRUE.equals(mapGlobalBlockedIPs.get(ip));
        } else {
            // otherwise, lookup the ip in the database; store it in the lookup table for future lookups
            if (database.genericBlacklistContainsIp(ip)) {
                mapGlobalBlockedIPs.put(ip, true);
                return true;
            } else {
                mapGlobalBlockedIPs.put(ip, false);
                return false;
            }
        }
    }

    /// Dummy class to hold a Rule-check result
    private static class RuleCheckResult{
        // if the target destination should be blocked
        public boolean blocked;
        // if the check can be stopped here. This is true if blocked = true or if blocked = false but it is a whitelisted target
        public boolean checkFinished;
        RuleCheckResult(boolean blocked){
            this.blocked = blocked;
            this.checkFinished = blocked;
        }
        RuleCheckResult(boolean blocked, boolean checkFinished){
            this.blocked = blocked;
            this.checkFinished = checkFinished;
        }
    }
    private enum CheckRuleTarget{ip, host}

    private RuleCheckResult blockedByRule(long uid, String value, CheckRuleTarget target){
        if(!mapUidRules.containsKey(uid)) return new RuleCheckResult(false);
        List<Rule> rules = mapUidRules.get(uid);
        assert rules != null;
        // NOTE: simply looping through the rules should work, because whitelist is added BEFORE blacklist in DatabaseHelper
        for(var rule : rules){
            Map<String, Boolean> ruleMap = null;
            switch (target){
                case ip:
                    ruleMap = rule.getIps();
                    break;
                case host:
                    ruleMap = rule.getHosts();
                    break;
            }
            if(ruleMap == null || ruleMap.isEmpty()) continue;
            boolean valueListed = ruleMap.containsKey(value);
            switch (rule.getType()) {
                case BLACKLIST:
                    return new RuleCheckResult(valueListed);
                case WHITELIST:
                    // the whitelist only applies, when values are provided! otherwise, the application can still be fully blocked
                    if (valueListed) {
                        // if the domain is whitelisted, it is automatically allowed
                        return new RuleCheckResult(false, true);
                    } else if (rule.getWhitelistExclusive()) {
                        // if the domain is not in the whitelist, we block only if the whitelist is exclusive (allowing no other domains)
                        return new RuleCheckResult(true);
                    }
            }
        }
        return new RuleCheckResult(false);
    }

    private String getDomainName(IPKey key){
        if(mapIPKeySni.containsKey(key)){
            return mapIPKeySni.get(key);
        }
        String domain = mapIpUidDomain.get(getMapIpUidDomainKey(key.getDaddr(),key.getUid()));
        if(domain == null || domain.isBlank()){
            domain = mapIpUidDomain.get(getMapIpUidDomainKey(key.getDaddr(),-1));
        }
        return domain;
    }

    private String getMapIpUidDomainKey(String ip, long uid){
        return ip+"_"+uid;
    }

}
