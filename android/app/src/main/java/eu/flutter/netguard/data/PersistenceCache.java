package eu.flutter.netguard.data;

import android.content.SharedPreferences;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import eu.flutter.netguard.NativeBridge;

public class PersistenceCache {
    private static final String PREF_FILTERED_PACKAGES = "filtered_packages";
    private static final String PREF_LOG_TRAFFIC = "log_traffic";
    private static final String PREF_OBSERVE_ONLY = "observe_only";
    private static final String PREF_LOG_LEVEL = "log_level";
    private static final String PREF_SESSION = "session";
    private static final String PREF_FINISHED = "finished";
    private static final String PREF_DB_PATH = "db_path";

    public static void StoreVpnConfig(SharedPreferences sharedPrefs, NativeBridge.VpnConfig vpnConfig){
        var editor = sharedPrefs.edit();
        editor.putString(PREF_DB_PATH, vpnConfig.getDbPath());
        editor.putString(PREF_SESSION, vpnConfig.getSession());
        editor.putLong(PREF_LOG_LEVEL, vpnConfig.getLogLevel());
        editor.putBoolean(PREF_LOG_TRAFFIC, vpnConfig.getLogTraffic());
        editor.putBoolean(PREF_OBSERVE_ONLY, vpnConfig.getObserveOnly());
        editor.putBoolean(PREF_FINISHED, vpnConfig.getFinished());
        editor.putStringSet(PREF_FILTERED_PACKAGES, Set.copyOf(vpnConfig.getFilteredPackages()));
        editor.apply();
    }
    public static NativeBridge.VpnConfig VpnConfig(SharedPreferences sharedPrefs){
        NativeBridge.VpnConfig.Builder builder = new NativeBridge.VpnConfig.Builder();
        builder.setDbPath(sharedPrefs.getString(PREF_DB_PATH, ""));
        builder.setSession(sharedPrefs.getString(PREF_SESSION, "")) ;
        builder.setLogLevel(sharedPrefs.getLong(PREF_LOG_LEVEL, 5));
        builder.setLogTraffic(sharedPrefs.getBoolean(PREF_LOG_TRAFFIC, false)) ;
        builder.setObserveOnly(sharedPrefs.getBoolean(PREF_OBSERVE_ONLY, false)) ;
        builder.setFinished(sharedPrefs.getBoolean(PREF_FINISHED, false)) ;
        builder.setFilteredPackages(List.copyOf(sharedPrefs.getStringSet(PREF_FILTERED_PACKAGES, new HashSet<>())));
        return builder.build();

    }
}
