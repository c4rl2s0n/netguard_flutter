package eu.flutter.netguard.utils;

import androidx.annotation.Nullable;

import eu.flutter.netguard.NativeBridge.*;

public class ModelBuilder {
    public static Allowed Allowed(String raddr, Long rport){
        Allowed.Builder builder = new Allowed.Builder();
        builder.setRaddr(raddr);
        builder.setRport(rport);
        return builder.build();
    }
    public static Allowed AllowedEmpty(){
        return new Allowed.Builder().build();
    }
}
