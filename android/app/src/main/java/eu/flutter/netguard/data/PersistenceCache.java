package eu.flutter.netguard.data;

import android.content.SharedPreferences;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import eu.flutter.netguard.flutter.NativeBridge;

public class PersistenceCache {
    public static final String PREF_FLUTTER_ENGINE_ATTACHED = "flutter_engine_attached";
    public static final String PREF_SERVICE_RUNNING = "vpn_service_running";
    private static final String PREF_FILTERED_PACKAGES = "filtered_packages";
    private static final String PREF_LOG_TRAFFIC = "log_traffic";
    private static final String PREF_OBSERVE_ONLY = "observe_only";
    private static final String PREF_LOG_LEVEL = "log_level";
    private static final String PREF_SESSION = "session";
    private static final String PREF_FINISHED = "finished";
    private static final String PREF_DB_PATH = "db_path";

    public static void SetFlutterEngineAttached(SharedPreferences sharedPrefs, boolean attached){
        sharedPrefs
            .edit()
            .putBoolean(PersistenceCache.PREF_FLUTTER_ENGINE_ATTACHED, attached)
            .apply();
    }
    public static boolean FlutterEngineAttached(SharedPreferences sharedPrefs){
        return sharedPrefs.getBoolean(PREF_FLUTTER_ENGINE_ATTACHED, false);
    }
    public static void SetVpnServiceRunning(SharedPreferences sharedPrefs, boolean running){
        sharedPrefs
            .edit()
            .putBoolean(PersistenceCache.PREF_SERVICE_RUNNING, running)
            .apply();
    }
    public static boolean VpnServiceRunning(SharedPreferences sharedPrefs){
        return sharedPrefs.getBoolean(PREF_SERVICE_RUNNING, false);
    }

    public static void StoreVpnConfig(SharedPreferences sharedPrefs, NativeBridge.VpnConfig vpnConfig){
        sharedPrefs.edit()
            .putString(PREF_DB_PATH, vpnConfig.getDbPath())
            .putString(PREF_SESSION, vpnConfig.getSession())
            .putLong(PREF_LOG_LEVEL, vpnConfig.getLogLevel())
            .putBoolean(PREF_LOG_TRAFFIC, vpnConfig.getLogTraffic())
            .putBoolean(PREF_OBSERVE_ONLY, vpnConfig.getObserveOnly())
            .putBoolean(PREF_FINISHED, vpnConfig.getFinished())
            .putStringSet(PREF_FILTERED_PACKAGES, Set.copyOf(vpnConfig.getFilteredPackages()))
            .apply();
    }
    public static NativeBridge.VpnConfig VpnConfig(SharedPreferences sharedPrefs){
        return new NativeBridge.VpnConfig.Builder()
            .setDbPath(sharedPrefs.getString(PREF_DB_PATH, ""))
            .setSession(sharedPrefs.getString(PREF_SESSION, ""))
            .setLogLevel(sharedPrefs.getLong(PREF_LOG_LEVEL, 5))
            .setLogTraffic(sharedPrefs.getBoolean(PREF_LOG_TRAFFIC, false))
            .setObserveOnly(sharedPrefs.getBoolean(PREF_OBSERVE_ONLY, false))
            .setFinished(sharedPrefs.getBoolean(PREF_FINISHED, false))
            .setFilteredPackages(List.copyOf(sharedPrefs.getStringSet(PREF_FILTERED_PACKAGES, new HashSet<>())))
            .build();
    }
}
