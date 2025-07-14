package eu.flutter.netguard.utils;

public class Protocols {
    public static final int ICMPv4 = 1;
    public static final int ICMPv6 = 58;
    public static final int TCP = 6;
    public static final int UDP = 17;

    public static boolean isSupported(long protocol){
        return protocol == ICMPv4 || protocol == ICMPv6 || protocol == TCP || protocol == UDP;
    }
}
