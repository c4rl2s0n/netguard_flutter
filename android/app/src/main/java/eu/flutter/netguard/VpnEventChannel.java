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
        return _vpnEventHandler != null;
    }


    public static void logText(String text){
        assert(isInitialized());
        _vpnEventHandler.logText(text, _voidResult);
    }
    public static void logError(String errorCode, String message, Object details){
        assert(isInitialized());
        _vpnEventHandler.logError(errorCode, message, details, _voidResult);
    }

    public static  void updateVpnState(boolean running){
        _vpnEventHandler.updateVpnState(running, _voidResult);
    }

    public static void logPacket(Packet packet){
        assert(isInitialized());
        _vpnEventHandler.logPacket(packet, _voidResult);
    }
    public static void logDns(ResourceRecord record){
        assert(isInitialized());
        _vpnEventHandler.logDns(record, _voidResult);
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
