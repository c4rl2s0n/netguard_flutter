package eu.flutter.netguard;

import androidx.annotation.NonNull;

import io.flutter.plugin.common.BinaryMessenger;
import eu.flutter.netguard.NativeBridge.*;

public class VpnEventChannel {

    public static VpnEventHandler _vpnEventHandler;

    public static void setUp(BinaryMessenger binaryMessenger) {
        _vpnEventHandler = new VpnEventHandler(binaryMessenger);
    }

    private static boolean isInitialized(){
        if(_vpnEventHandler == null) return false;
        return true;
    }


    public static void logText(String text){
        assert(isInitialized());
        _vpnEventHandler.logText(text, _voidResult);
    }
    public static void logError(String errorCode, String message, Object details){
        assert(isInitialized());
        _vpnEventHandler.logError(errorCode, message, details, _voidResult);
    }

    public static void sendEvent(Packet packet){
        assert(isInitialized());
        _vpnEventHandler.sendEvent(packet, _voidResult);
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
