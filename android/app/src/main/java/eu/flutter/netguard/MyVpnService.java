package eu.flutter.netguard;

import android.annotation.TargetApi;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.pm.PackageManager;
import android.content.res.Configuration;
import android.net.ConnectivityManager;
import android.net.LinkProperties;
import android.net.Network;
import android.net.VpnService;
import android.os.Build;
import android.os.Bundle;
import android.os.HandlerThread;
import android.os.Looper;
import android.os.ParcelFileDescriptor;
import android.os.PowerManager;
import android.os.Process;
import android.text.TextUtils;
import android.util.Log;

import androidx.preference.PreferenceManager;

import java.net.Inet4Address;
import java.net.InetAddress;
import java.net.InetSocketAddress;
import java.net.UnknownHostException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.locks.ReentrantReadWriteLock;

import eu.flutter.netguard.data.DatabaseHelper;
import eu.flutter.netguard.data.models.IPKey;
import eu.flutter.netguard.data.models.Rule;
import eu.flutter.netguard.data.models.Version;
import eu.flutter.netguard.data.models.IPRule;
import eu.flutter.netguard.utils.*;
import eu.flutter.netguard.NativeBridge.*;

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
    private native void jni_run(long context, int tun, boolean fwd53, int rcode);
    private native void jni_stop(long context);
    private native void jni_clear(long context);
    private native int jni_get_mtu();
    private native int[] jni_get_stats(long context);
    private native void jni_socks5(String addr, int port, String username, String password);
    private native void jni_done(long context);

    private Thread tunnelThread = null;
    private final ReentrantReadWriteLock lock = new ReentrantReadWriteLock(true);

    private ParcelFileDescriptor vpnInterface;
    private VpnSettings settings;

    private LogHandler logHandler;

    private Map<String, Boolean> mapHostsBlocked = new HashMap<>();
    private Map<String, Boolean> mapMalware = new HashMap<>();
    private Map<Long, Boolean> mapUidAllowed = new HashMap<>();
    private Map<Integer, Integer> mapUidKnown = new HashMap<>();
    private final Map<IPKey, Map<InetAddress, IPRule>> mapUidIPFilters = new HashMap<>();
    private Map<Long, Forward> mapForward = new HashMap<>();
    private Map<Long, Boolean> mapNotify = new HashMap<>();
    private static boolean running = false;

    public static boolean isRunning() {
        return running;
    }


    @Override
    public void onCreate() {
        Log.i(TAG, "Create version=" + Util.getSelfVersionName(this) + "/" + Util.getSelfVersionCode(this));

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

        return;
        /// TODO: Maybe register some of these listeners from SinkholeService.onCreate
        ///  i.e. idleState, connectivity, alarmManager, ... (?)
    }
    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        Log.i("MyVpnService", "VPN starting...");
        if (intent != null) {
            String action = intent.getAction();

            if(intent.hasExtra(Values.Intent.Extras.VPN_SETTINGS)) {
                Bundle settingsBundle = intent.getBundleExtra(Values.Intent.Extras.VPN_SETTINGS);
                VpnSettings settings = Util.deserializeSettings(settingsBundle);
                updateVpnSettings(settings);
            }

            switch (action) {
                case Values.Intent.Actions.START:
                    startVpn();
                    break;
                case Values.Intent.Actions.UPDATE_SETTINGS:
                    // This happens everytime an intent with settings is received
                    break;
                case Values.Intent.Actions.STOP:
                    stopVpn();
                    break;
            }
        }


        return START_STICKY;
    }

    private void updateVpnSettings(VpnSettings settings){
        if(settings == null) return;
        this.settings = settings;
    }
    private void startVpn(){
        if (vpnInterface != null) return;

        logHandler.logText("Starting the VPN!");

        SharedPreferences prefs = PreferenceManager.getDefaultSharedPreferences(MyVpnService.this);
        prefs.edit().putBoolean("filter", true).apply();
        // Keep awake
        WakeLock.getLock(this).acquire();

        Builder builder = getBuilder(new ArrayList<Rule>(),new ArrayList<Rule>());
//        Builder builder = new Builder();
//        builder.setSession("MyVPN")
//                .addAddress("10.0.0.2", 24)
//                .addDnsServer("1.1.1.1")
//                .addRoute("0.0.0.0", 0)  // Redirect all traffic
//                .setSession("NetGuard");

        try {
            vpnInterface = builder.establish();
            if (vpnInterface == null) {
                Log.e(TAG, "Failed to establish VPN interface");
            } else {
                Log.i(TAG, "VPN interface established");
                running = true;
                // TODO: Start your VPN processing thread
                // TODO: provide actual rules here!
                startNative(vpnInterface, new ArrayList<Rule>(), new ArrayList<Rule>());

                return;
            }
        } catch (Exception e) {
            Log.e(TAG, "Failed to start VPN", e);
        }
        running = false;
    }
    void stopVpn(){
        stopNative();
        if (vpnInterface != null) {
            try {
                vpnInterface.close();
                running = false;
            } catch (Exception ignored) {}
            vpnInterface = null;
        }
        // release WakeLock
        WakeLock.releaseLock(this);

        logHandler.logText("VPN stopped!");
        Log.i(TAG, "VPN stopped");
    }

    @Override
    public void onDestroy() {
        running = false;
        Log.i(TAG, "VPN stopping...");
        stopVpn();

        super.onDestroy();
    }



    private Builder getBuilder(List<Rule> listAllowed, List<Rule> listRule) {
        SharedPreferences prefs = PreferenceManager.getDefaultSharedPreferences(MyVpnService.this);
        boolean subnet = prefs.getBoolean("subnet", false);
        boolean tethering = prefs.getBoolean("tethering", false);
        boolean lan = prefs.getBoolean("lan", false);
        boolean ip6 = prefs.getBoolean("ip6", true);
        boolean filter = prefs.getBoolean("filter", false);
        boolean system = prefs.getBoolean("manage_system", false);

        // Build VPN service
        Builder builder = new Builder();
        builder.setSession(getString(R.string.app_name));

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q)
            builder.setMetered(Util.isMeteredNetwork(this));

        // VPN address
        String vpn4 = prefs.getString("vpn4", "10.1.10.1");
        Log.i(TAG, "Using VPN4=" + vpn4);
        builder.addAddress(vpn4, 32);
        if (ip6) {
            String vpn6 = prefs.getString("vpn6", "fd00:1:fd00:1:fd00:1:fd00:1");
            Log.i(TAG, "Using VPN6=" + vpn6);
            builder.addAddress(vpn6, 128);
        }

        // DNS address
        if (filter)
            for (InetAddress dns : DNS.getDns(MyVpnService.this)) {
                if (ip6 || dns instanceof Inet4Address) {
                    Log.i(TAG, "Using DNS=" + dns);
                    builder.addDnsServer(dns);
                }
            }

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
                Log.e(TAG, ex.toString() + "\n" + Log.getStackTraceString(ex));
            }

        // Subnet routing
        if (subnet) {
            // Exclude IP ranges
            List<IPUtil.CIDR> listExclude = new ArrayList<>();
            listExclude.add(new IPUtil.CIDR("127.0.0.0", 8)); // localhost

            if (tethering && !lan) {
                // USB tethering 192.168.42.x
                // Wi-Fi tethering 192.168.43.x
                listExclude.add(new IPUtil.CIDR("192.168.42.0", 23));
                // Bluetooth tethering 192.168.44.x
                listExclude.add(new IPUtil.CIDR("192.168.44.0", 24));
                // Wi-Fi direct 192.168.49.x
                listExclude.add(new IPUtil.CIDR("192.168.49.0", 24));
            }

            if (lan) {
                // https://tools.ietf.org/html/rfc1918
                listExclude.add(new IPUtil.CIDR("10.0.0.0", 8));
                listExclude.add(new IPUtil.CIDR("172.16.0.0", 12));
                listExclude.add(new IPUtil.CIDR("192.168.0.0", 16));
            }

            if (!filter) {
                for (InetAddress dns : DNS.getDns(MyVpnService.this))
                    if (dns instanceof Inet4Address)
                        listExclude.add(new IPUtil.CIDR(dns.getHostAddress(), 32));

                String dns_specifier = Util.getPrivateDnsSpecifier(MyVpnService.this);
                if (!TextUtils.isEmpty(dns_specifier))
                    try {
                        Log.i(TAG, "Resolving private dns=" + dns_specifier);
                        for (InetAddress pdns : InetAddress.getAllByName(dns_specifier))
                            if (pdns instanceof Inet4Address)
                                listExclude.add(new IPUtil.CIDR(pdns.getHostAddress(), 32));
                    } catch (Throwable ex) {
                        Log.e(TAG, ex.toString());
                    }
            }

            // https://en.wikipedia.org/wiki/Mobile_country_code
            Configuration config = getResources().getConfiguration();

            // T-Mobile Wi-Fi calling
            if (config.mcc == 310 && (config.mnc == 160 ||
                    config.mnc == 200 ||
                    config.mnc == 210 ||
                    config.mnc == 220 ||
                    config.mnc == 230 ||
                    config.mnc == 240 ||
                    config.mnc == 250 ||
                    config.mnc == 260 ||
                    config.mnc == 270 ||
                    config.mnc == 310 ||
                    config.mnc == 490 ||
                    config.mnc == 660 ||
                    config.mnc == 800)) {
                listExclude.add(new IPUtil.CIDR("66.94.2.0", 24));
                listExclude.add(new IPUtil.CIDR("66.94.6.0", 23));
                listExclude.add(new IPUtil.CIDR("66.94.8.0", 22));
                listExclude.add(new IPUtil.CIDR("208.54.0.0", 16));
            }

            // Verizon wireless calling
            if ((config.mcc == 310 &&
                    (config.mnc == 4 ||
                            config.mnc == 5 ||
                            config.mnc == 6 ||
                            config.mnc == 10 ||
                            config.mnc == 12 ||
                            config.mnc == 13 ||
                            config.mnc == 350 ||
                            config.mnc == 590 ||
                            config.mnc == 820 ||
                            config.mnc == 890 ||
                            config.mnc == 910)) ||
                    (config.mcc == 311 && (config.mnc == 12 ||
                            config.mnc == 110 ||
                            (config.mnc >= 270 && config.mnc <= 289) ||
                            config.mnc == 390 ||
                            (config.mnc >= 480 && config.mnc <= 489) ||
                            config.mnc == 590)) ||
                    (config.mcc == 312 && (config.mnc == 770))) {
                listExclude.add(new IPUtil.CIDR("66.174.0.0", 16)); // 66.174.0.0 - 66.174.255.255
                listExclude.add(new IPUtil.CIDR("66.82.0.0", 15)); // 69.82.0.0 - 69.83.255.255
                listExclude.add(new IPUtil.CIDR("69.96.0.0", 13)); // 69.96.0.0 - 69.103.255.255
                listExclude.add(new IPUtil.CIDR("70.192.0.0", 11)); // 70.192.0.0 - 70.223.255.255
                listExclude.add(new IPUtil.CIDR("97.128.0.0", 9)); // 97.128.0.0 - 97.255.255.255
                listExclude.add(new IPUtil.CIDR("174.192.0.0", 9)); // 174.192.0.0 - 174.255.255.255
                listExclude.add(new IPUtil.CIDR("72.96.0.0", 9)); // 72.96.0.0 - 72.127.255.255
                listExclude.add(new IPUtil.CIDR("75.192.0.0", 9)); // 75.192.0.0 - 75.255.255.255
                listExclude.add(new IPUtil.CIDR("97.0.0.0", 10)); // 97.0.0.0 - 97.63.255.255
            }

            // SFR MMS
            if (config.mnc == 10 && config.mcc == 208)
                listExclude.add(new IPUtil.CIDR("10.151.0.0", 24));

            // Broadcast
            listExclude.add(new IPUtil.CIDR("224.0.0.0", 3));

            Collections.sort(listExclude);

            try {
                InetAddress start = InetAddress.getByName("0.0.0.0");
                for (IPUtil.CIDR exclude : listExclude) {
                    Log.i(TAG, "Exclude " + exclude.getStart().getHostAddress() + "..." + exclude.getEnd().getHostAddress());
                    for (IPUtil.CIDR include : IPUtil.toCIDR(start, IPUtil.minus1(exclude.getStart())))
                        try {
                            builder.addRoute(include.address, include.prefix);
                        } catch (Throwable ex) {
                            Log.e(TAG, ex.toString() + "\n" + Log.getStackTraceString(ex));
                        }
                    start = IPUtil.plus1(exclude.getEnd());
                }
                String end = (lan ? "255.255.255.254" : "255.255.255.255");
                for (IPUtil.CIDR include : IPUtil.toCIDR("224.0.0.0", end))
                    try {
                        builder.addRoute(include.address, include.prefix);
                    } catch (Throwable ex) {
                        Log.e(TAG, ex.toString() + "\n" + Log.getStackTraceString(ex));
                    }
            } catch (UnknownHostException ex) {
                Log.e(TAG, ex.toString() + "\n" + Log.getStackTraceString(ex));
            }
        } else
            builder.addRoute("0.0.0.0", 0);

        Log.i(TAG, "IPv6=" + ip6);
        if (ip6)
            builder.addRoute("2000::", 3); // unicast

        // MTU
        int mtu = jni_get_mtu();
        Log.i(TAG, "MTU=" + mtu);
        builder.setMtu(mtu);

        // Add list of allowed applications
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            //if (last_connected && !filter) {
            if (!filter) {
                Map<String, Rule> mapDisallowed = new HashMap<>();
                for (Rule rule : listRule)
                    mapDisallowed.put(rule.packageName, rule);
                for (Rule rule : listAllowed)
                    mapDisallowed.remove(rule.packageName);
                for (String packageName : mapDisallowed.keySet())
                    try {
                        builder.addAllowedApplication(packageName);
                        Log.i(TAG, "Sinkhole " + packageName);
                    } catch (PackageManager.NameNotFoundException ex) {
                        Log.e(TAG, ex.toString() + "\n" + Log.getStackTraceString(ex));
                    }
                if (mapDisallowed.size() == 0)
                    try {
                        builder.addAllowedApplication(getPackageName());
                    } catch (PackageManager.NameNotFoundException ex) {
                        Log.e(TAG, ex.toString() + "\n" + Log.getStackTraceString(ex));
                    }
            } else if (filter) {
                try {
                    builder.addDisallowedApplication(getPackageName());
                } catch (PackageManager.NameNotFoundException ex) {
                    Log.e(TAG, ex.toString() + "\n" + Log.getStackTraceString(ex));
                }
                for (Rule rule : listRule)
                    if (!rule.apply || (!system && rule.system))
                        try {
                            Log.i(TAG, "Not routing " + rule.packageName);
                            builder.addDisallowedApplication(rule.packageName);
                        } catch (PackageManager.NameNotFoundException ex) {
                            Log.e(TAG, ex.toString() + "\n" + Log.getStackTraceString(ex));
                        }
            }
        }

        // Build configure intent // TODO: What is that?!
//        Intent configure = new Intent(this, ActivityMain.class);
//        PendingIntent pi = PendingIntentCompat.getActivity(this, 0, configure, PendingIntent.FLAG_UPDATE_CURRENT);
//        builder.setConfigureIntent(pi);

        return builder;
    }
    private void startNative(final ParcelFileDescriptor vpn, List<Rule> listAllowed, List<Rule> listRule) {
        SharedPreferences prefs = PreferenceManager.getDefaultSharedPreferences(MyVpnService.this);
        boolean log = prefs.getBoolean("log", false);
        boolean log_app = prefs.getBoolean("log_app", false);
        boolean filter = prefs.getBoolean("filter", false);
        filter = true;

        Log.i(TAG, "Start native log=" + log + "/" + log_app + " filter=" + filter);

        // Prepare rules
//        if (filter) {
//            prepareUidAllowed(listAllowed, listRule);
//            prepareHostsBlocked();
//            prepareMalwareList();
//            prepareUidIPFilters(null);
//            prepareForwarding();
//        } else {
//            lock.writeLock().lock();
//            mapUidAllowed.clear();
//            mapUidKnown.clear();
//            mapHostsBlocked.clear();
//            mapMalware.clear();
//            mapUidIPFilters.clear();
//            mapForward.clear();
//            lock.writeLock().unlock();
//        }
//
//        if (log_app)
//            prepareNotify(listRule);
//        else {
//            lock.writeLock().lock();
//            mapNotify.clear();
//            lock.writeLock().unlock();
//        }

        if (log || log_app || filter) {
            int prio = Integer.parseInt(prefs.getString("loglevel", Integer.toString(Log.WARN)));
            final int rcode = Integer.parseInt(prefs.getString("rcode", "3"));
            if (prefs.getBoolean("socks5_enabled", false))
                jni_socks5(
                        prefs.getString("socks5_addr", ""),
                        Integer.parseInt(prefs.getString("socks5_port", "0")),
                        prefs.getString("socks5_username", ""),
                        prefs.getString("socks5_password", ""));
            else
                jni_socks5("", 0, "", "");

            if (tunnelThread == null) {
                Log.i(TAG, "Starting tunnel thread context=" + jni_context);
                jni_start(jni_context, prio);

                tunnelThread = new Thread(new Runnable() {
                    @Override
                    public void run() {
                        Log.i(TAG, "Running tunnel context=" + jni_context);
                        jni_run(jni_context, vpn.getFd(), true /* TODO: mapForward.containsKey(53)*/, rcode);
                        Log.i(TAG, "Tunnel exited");
                        tunnelThread = null;
                    }
                });
                //tunnelThread.setPriority(Thread.MAX_PRIORITY);
                tunnelThread.start();

                Log.i(TAG, "Started tunnel thread");
            }
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

    // Called from native code
    private void nativeExit(String reason) {
        Log.w(TAG, "Native exit reason=" + reason);
        if (reason != null) {
            // TODO: showErrorNotification(reason);

            SharedPreferences prefs = PreferenceManager.getDefaultSharedPreferences(this);
            prefs.edit().putBoolean("enabled", false).apply();
            // TODO: WidgetMain.updateWidgets(this);
        }
    }

    // Called from native code
    private void nativeError(int error, String message) {
        Log.w(TAG, "Native error " + error + ": " + message);
        // TODO: showErrorNotification(message);
    }

    // Called from native code
    private void logPacket(Packet packet) {
        logHandler.queue(packet);
    }
    // Called from native code
    private void accountUsage(Usage usage) {
        logHandler.account(usage);
    }

    // Called from native code
    private void dnsResolved(ResourceRecord rr) {
        // TODO: insert ResourceRecord to Database
        if (DatabaseHelper.getInstance(MyVpnService.this).insertDns(rr)) {
            Log.i(TAG, "New IP " + rr);
            Log.i(TAG, "New IP (AName)" + rr.getAName());
            //TODO: prepareUidIPFilters(rr.QName);
        }
        // check if resource record is malware
        if (rr.getUid() > 0 && !TextUtils.isEmpty(rr.getAName())) {
            lock.readLock().lock();
            boolean malware = (mapMalware.containsKey(rr.getAName()) && mapMalware.get(rr.getAName()));
            lock.readLock().unlock();

            if (malware) {
                SharedPreferences prefs = PreferenceManager.getDefaultSharedPreferences(this);
                boolean notified = prefs.getBoolean("malware." + rr.getUid(), false);
                if (!notified) {
                    prefs.edit().putBoolean("malware." + rr.getUid(), true).apply();
                    // TODO: notifyNewApplication(rr.uid, true);
                }
            }
        }
    }

    // Called from native code
    private boolean isDomainBlocked(String name) {
        lock.readLock().lock();
        boolean blocked = (mapHostsBlocked.containsKey(name) && mapHostsBlocked.get(name));
        lock.readLock().unlock();
        return blocked;
    }

    // Called from native code
    @TargetApi(Build.VERSION_CODES.Q)
    private int getUidQ(int version, int protocol, String saddr, int sport, String daddr, int dport) {
        if (protocol != 6 /* TCP */ && protocol != 17 /* UDP */)
            return Process.INVALID_UID;

        ConnectivityManager cm = (ConnectivityManager) getSystemService(CONNECTIVITY_SERVICE);
        if (cm == null)
            return Process.INVALID_UID;

        InetSocketAddress local = new InetSocketAddress(saddr, sport);
        InetSocketAddress remote = new InetSocketAddress(daddr, dport);

        Log.i(TAG, "Get uid local=" + local + " remote=" + remote);
        int uid = cm.getConnectionOwnerUid(protocol, local, remote);
        Log.i(TAG, "Get uid=" + uid);
        return uid;
    }
    private Allowed isAddressAllowed(Packet packet) {
        SharedPreferences prefs = PreferenceManager.getDefaultSharedPreferences(this);

        lock.readLock().lock();
        logHandler.queue(packet);
        packet.setAllowed(true);
        if (prefs.getBoolean("filter", false)) {
            // https://android.googlesource.com/platform/system/core/+/master/include/private/android_filesystem_config.h
            if (packet.getProtocol() == Protocols.UDP && !prefs.getBoolean("filter_udp", false)) {
                // Allow unfiltered UDP
                packet.setAllowed(true);
                Log.i(TAG, "Allowing UDP " + packet);
            } else if (packet.getUid() < 2000 &&
                    /* TODO: !last_connected &&*/ Protocols.isSupported(packet.getProtocol()) && false) {
                // Allow system applications in disconnected state
                packet.setAllowed(true);
                Log.w(TAG, "Allowing disconnected system " + packet);
//            } else if ((packet.uid < 2000 || BuildConfig.PLAY_STORE_RELEASE) &&
//                    !mapUidKnown.containsKey(packet.uid) && Protocols.isSupported(packet.protocol)) {
//                // Allow unknown (system) traffic
//                packet.allowed = true;
//                Log.w(TAG, "Allowing unknown system " + packet);
            } else if (packet.getUid() == android.os.Process.myUid()) {
                // Allow self
                packet.setAllowed(true);
                Log.w(TAG, "Allowing self " + packet);
            } else {
                boolean filtered = false;
                IPKey key = new IPKey(packet.getVersion(), packet.getProtocol(), packet.getDport(), packet.getUid());
                if (mapUidIPFilters.containsKey(key))
                    try {
                        InetAddress iaddr = InetAddress.getByName(packet.getDaddr());
                        Map<InetAddress, IPRule> map = mapUidIPFilters.get(key);
                        if (map != null && map.containsKey(iaddr)) {
                            IPRule rule = map.get(iaddr);
                            if (rule.isExpired())
                                Log.i(TAG, "DNS expired " + packet + " rule " + rule);
                            else {
                                filtered = true;
                                packet.setAllowed(!rule.isBlocked());
                                Log.i(TAG, "Filtering " + packet +
                                        " allowed=" + packet.getAllowed() + " rule " + rule);
                            }
                        }
                    } catch (UnknownHostException ex) {
                        Log.w(TAG, "Allowed " + ex.toString() + "\n" + Log.getStackTraceString(ex));
                    }

                if (!filtered)
                    if (mapUidAllowed.containsKey(packet.getUid()))
                        packet.setAllowed(mapUidAllowed.get(packet.getUid()));
                    else
                        Log.w(TAG, "No rules for " + packet);
            }
        }

        Allowed allowed = null;
        if (packet.getAllowed()) {
            if (mapForward.containsKey(packet.getDport())) {
                Forward fwd = mapForward.get(packet.getDport());
                if (fwd.getRuid().equals(packet.getUid())) {
                    allowed = ModelBuilder.AllowedEmpty();
                } else {
                    allowed = ModelBuilder.Allowed(fwd.getRaddr(), fwd.getRport());
                    packet.setData("> " + fwd.getRaddr() + "/" + fwd.getRport());
                }
            } else
                allowed = new Allowed();
        }

        lock.readLock().unlock();

        if (prefs.getBoolean("log", false) || prefs.getBoolean("log_app", false))
            if (packet.getProtocol() != Protocols.TCP || !"".equals(packet.getFlags()))
                if (packet.getUid() != Process.myUid())
                    logPacket(packet);

        return allowed;
    }

}
