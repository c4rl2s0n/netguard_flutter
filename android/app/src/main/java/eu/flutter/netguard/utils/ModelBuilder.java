package eu.flutter.netguard.utils;

import androidx.annotation.Nullable;

import eu.flutter.netguard.NativeBridge;
import eu.flutter.netguard.NativeBridge.*;

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
}
