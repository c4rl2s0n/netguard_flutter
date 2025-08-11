package eu.flutter.netguard.flutter;

import android.content.Context;
import android.content.SharedPreferences;

import androidx.annotation.NonNull;
import androidx.preference.PreferenceManager;

import eu.flutter.netguard.data.PersistenceCache;
import eu.flutter.netguard.utils.Log;
import io.flutter.plugin.common.BinaryMessenger;
import eu.flutter.netguard.flutter.NativeBridge.*;

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

    public static void updateVpnState(boolean running){
        if(notInitialized()) return;
        _vpnEventHandler.updateVpnState(running, _voidResult);
    }

    public static void logTraffic(TrafficLog log){
        if(notInitialized()) return;
        _vpnEventHandler.logTraffic(log, _voidResult);
    }
    public static void closeFlutterEngine(){
        if(notInitialized()) return;
        _vpnEventHandler.closeFlutterEngine(_voidResult);
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
