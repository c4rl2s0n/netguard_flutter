package eu.flutter.netguard.data;

import java.util.HashMap;

import eu.flutter.netguard.NativeBridge;
import eu.flutter.netguard.NativeBridge.*;
import io.flutter.Log;

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

    public static Rule Rule(String packageName, RuleType type){
        Rule.Builder builder = new Rule.Builder();
        builder.setPackageName(packageName);
        builder.setType(type);
        builder.setBlockQuic(false);
        builder.setHosts(new HashMap<>());
        builder.setIps(new HashMap<>());
        return builder.build();
    }

    public static TrafficLog TrafficLog(long time, String session, String packageName, int protocol, String ip, String host, boolean allowed){
        Log.i("ModelBuilder TrafficLog", "PackageName: "+packageName);
        TrafficLog.Builder builder = new TrafficLog.Builder();
        builder.setTime(time);
        builder.setSession(session);
        builder.setPackageName(packageName);
        builder.setProtocol((long)protocol);
        builder.setIp(ip);
        builder.setHost(host.isBlank() ? null : host);
        builder.setAllowed(allowed);
        return builder.build();
    }


}
