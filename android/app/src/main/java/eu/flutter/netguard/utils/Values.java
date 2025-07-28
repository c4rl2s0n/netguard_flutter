package eu.flutter.netguard.utils;

import android.app.Notification;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.os.Build;
import android.util.TypedValue;

import androidx.core.app.NotificationCompat;

public class Values {
    public static class Paths{
        public static final String database = "app_flutter/netguard/netguard.db";
        public static String database(Context context) {
            return context.getApplicationInfo().dataDir+"/"+ database;
        }
    }
    public static class Intent{
        public static class Actions{
            public static final String START = "START";
            public static final String RELOAD = "RELOAD";
            public static final String STOP = "STOP";
        }
    }
}
