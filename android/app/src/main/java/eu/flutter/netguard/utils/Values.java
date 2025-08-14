package eu.flutter.netguard.utils;

import android.content.Context;

public class Values {
    public static class Paths{
        public static final String flutter_base = "app_flutter/netguard/";
        public static final String database = flutter_base + "/netguard.db";
        public static String database(Context context) {
            return context.getApplicationInfo().dataDir+"/"+ database;
        }
    }
    public static class Intent{
        public static class Actions{
            public static final String START = "START";
            public static final String RELOAD = "RELOAD";
            public static final String STOP = "STOP";
            public static final String PUSH_STATS = "PUSH_STATS";
        }
        public static class Extras{
            public static class SessionStatistics {
                public static final String packetCountAllowed = "packetCount";
                public static final String packetSizeAllowed = "packetSize";
                public static final String packetCountBlocked = "packetCountBlocked";
                public static final String packetSizeBlocked = "packetSizeBlocked";
                public static final String mostTrafficPackage = "mostTrafficPackage";
                public static final String mostBlockedPackage = "mostBlockedPackage";

            }

        }
    }
}
