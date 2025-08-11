package eu.flutter.netguard.data;

import eu.flutter.netguard.flutter.NativeBridge;

public class ModelExtensions {

    public static class SessionStatistics{
        public static Long packetCount(NativeBridge.SessionStatistics sessionStatistics){
            return sessionStatistics.getPacketCountAllowed() + sessionStatistics.getPacketCountBlocked();
        }
        public static Long packetSize(NativeBridge.SessionStatistics sessionStatistics){
            return sessionStatistics.getPacketSizeAllowed() + sessionStatistics.getPacketSizeBlocked();
        }
    }
}
