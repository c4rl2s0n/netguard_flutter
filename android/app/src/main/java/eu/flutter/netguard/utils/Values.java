package eu.flutter.netguard.utils;

import android.app.Notification;
import android.app.PendingIntent;
import android.content.Intent;
import android.os.Build;
import android.util.TypedValue;

import androidx.core.app.NotificationCompat;

public class Values {
    public static class Intent{
        public static class Actions{
            public static final String START = "START";
            public static final String STOP = "STOP";
            public static final String UPDATE_SETTINGS = "UPDATE_SETTINGS";
        }
        public static class Extras{
            public static final String VPN_CONFIG = "VPN_CONFIG";
            public static final String VPN_CONFIG_BLOCK_TRAFFIC = "blockTraffic";
            public static final String VPN_CONFIG_IGNORED_PACKAGES = "ignoredPackages";
            public static final String VPN_CONFIG_GLOBAL_RULE = "globalRule";
            public static final String VPN_CONFIG_PACKAGE_RULES = "packageRules";
        }
    }
}
