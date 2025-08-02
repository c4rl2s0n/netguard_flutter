package eu.flutter.netguard;

import androidx.annotation.NonNull;

import io.flutter.plugin.common.BinaryMessenger;
import eu.flutter.netguard.NativeBridge.*;

public class VpnEventChannel {

    public static VpnEventHandler _vpnEventHandler;

    public static void setUp(BinaryMessenger binaryMessenger) {
        _vpnEventHandler = new VpnEventHandler(binaryMessenger);
    }

    private static boolean notInitialized(){
        return _vpnEventHandler == null;
    }

    public static void logText(String text){
        if(notInitialized()) return;
        _vpnEventHandler.logText(text, _voidResult);
    }
    public static void logError(String errorCode, String message, Object details){
        if(notInitialized()) return;
        _vpnEventHandler.logError(errorCode, message, details, _voidResult);
    }

    public static void updateVpnState(String sessionId){
        if(notInitialized()) return;
        _vpnEventHandler.updateVpnState(sessionId, _voidResult);
    }

    public static void logTraffic(TrafficLog log){
        if(notInitialized()) return;
        _vpnEventHandler.logTraffic(log, _voidResult);
    }

    private static final VoidResult _voidResult = new VoidResult() {
        @Override
        public void success() {

        }

        @Override
        public void error(@NonNull Throwable error) {

        }
    };

}
