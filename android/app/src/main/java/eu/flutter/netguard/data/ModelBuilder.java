package eu.flutter.netguard.data;

import android.os.Bundle;

import java.util.HashMap;

import eu.flutter.netguard.NativeBridge.*;
import eu.flutter.netguard.utils.Values;

public class ModelBuilder {
    public static Application Application(long uid, String packageName, String label, String version, byte[] icon, boolean system){
        Application.Builder builder = new Application.Builder();
        builder.setUid(uid);
        builder.setPackageName(packageName);
        builder.setLabel(label);
        builder.setVersion(version);
        builder.setIcon(icon);
        builder.setSystem(system);
        return builder.build();
    }
    public static ApplicationSetting ApplicationSetting(String packageName, boolean filter, boolean blockAll, boolean blockQuic){
        ApplicationSetting.Builder builder = new ApplicationSetting.Builder();
        builder.setPackageName(packageName);
        builder.setFilter(filter);
        builder.setBlockAll(blockAll);
        builder.setBlockQuic(blockQuic);
        return builder.build();
    }

    public static Rule Rule(String packageName, RuleType type){
        Rule.Builder builder = new Rule.Builder();
        builder.setPackageName(packageName);
        builder.setType(type);
        builder.setShouldBlockQuic(false);
        builder.setWhitelistExclusive(false);
        builder.setHosts(new HashMap<>());
        builder.setIps(new HashMap<>());
        return builder.build();
    }

    public static TrafficLog TrafficLog(long time, String session, String packageName, int protocol, String ip, String host, int dport, long size, boolean allowed, boolean outgoing){
        TrafficLog.Builder builder = new TrafficLog.Builder();
        builder.setTime(time);
        builder.setSession(session);
        builder.setPackageName(packageName);
        builder.setProtocol((long)protocol);
        builder.setDport((long)dport);
        builder.setIp(ip);
        builder.setHost(host == null || host.isBlank() ? null : host);
        builder.setSize(size);
        builder.setAllowed(allowed);
        builder.setOutgoing(outgoing);
        return builder.build();
    }

    public static Bundle toBundle(SessionStatistics statistics){
        var bundle = new Bundle();
        bundle.putLong(Values.Intent.Extras.SessionStatistics.packetCountAllowed, statistics.getPacketCountAllowed());
        bundle.putLong(Values.Intent.Extras.SessionStatistics.packetSizeAllowed, statistics.getPacketSizeAllowed());
        bundle.putLong(Values.Intent.Extras.SessionStatistics.packetCountBlocked, statistics.getPacketCountBlocked());
        bundle.putLong(Values.Intent.Extras.SessionStatistics.packetSizeBlocked, statistics.getPacketSizeBlocked());
        bundle.putString(Values.Intent.Extras.SessionStatistics.mostTrafficPackage, statistics.getMostTrafficPackage());
        bundle.putString(Values.Intent.Extras.SessionStatistics.mostBlockedPackage, statistics.getMostBlockedPackage());
        return bundle;
    }
    public static SessionStatistics SessionStatisticsFromBundle(Bundle bundle){
        SessionStatistics.Builder builder = new SessionStatistics.Builder();
        builder.setPacketCountAllowed(bundle.getLong(Values.Intent.Extras.SessionStatistics.packetCountAllowed));
        builder.setPacketSizeAllowed(bundle.getLong(Values.Intent.Extras.SessionStatistics.packetSizeAllowed));
        builder.setPacketCountBlocked(bundle.getLong(Values.Intent.Extras.SessionStatistics.packetCountBlocked));
        builder.setPacketSizeBlocked(bundle.getLong(Values.Intent.Extras.SessionStatistics.packetSizeBlocked));
        builder.setMostTrafficPackage(bundle.getString(Values.Intent.Extras.SessionStatistics.mostTrafficPackage));
        builder.setMostBlockedPackage(bundle.getString(Values.Intent.Extras.SessionStatistics.mostBlockedPackage));
        return builder.build();
    }

}
