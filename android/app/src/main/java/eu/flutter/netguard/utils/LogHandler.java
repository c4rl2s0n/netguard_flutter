package eu.flutter.netguard.utils;


import android.content.Context;
import android.os.Handler;
import android.os.Looper;
import android.os.Message;


import androidx.annotation.NonNull;

import eu.flutter.netguard.flutter.FlutterEngineManager;
import eu.flutter.netguard.flutter.NativeBridge.*;
import eu.flutter.netguard.flutter.VpnEventChannel;

public final class LogHandler extends Handler {
    private static final String TAG = "NetGuard.LogHandler";

    private static final int MSG_TRAFFIC = 1;
    public int queue = 0;

    private static final int MAX_QUEUE = 500;

    Context context;

    public LogHandler(Context context, Looper looper) {
        super(looper);
        this.context = context;
    }

    public void queue(Message msg) {
        synchronized (this) {
            if (queue > MAX_QUEUE) {
                Log.w(TAG, "Log queue full");
                return;
            }
            sendMessage(msg);
            queue++;
        }
    }

    public void traffic(TrafficLog log){
        Message msg = obtainMessage();
        msg.obj = log;
        msg.what = MSG_TRAFFIC;
        queue(msg);
    }

    @Override
    public void handleMessage(@NonNull Message msg) {
        try {
            synchronized (this) {
                queue--;
            }

            // if buffering, just re-append the message
            if(FlutterEngineManager.getInstance(context).getIsBuffering()){
                queue(msg);
                return;
            }
            switch (msg.what) {
                case MSG_TRAFFIC:
                    VpnEventChannel.logTraffic((TrafficLog) msg.obj);
                    break;

                default:
                    Log.e(TAG, "Unknown log message=" + msg.what);
            }


        } catch (Throwable ex) {
            Log.e(TAG, ex + "\n" + Log.getStackTraceString(ex));
        }
    }

    public void logText(String text){
        VpnEventChannel.logText(text);
    }
    public void logError(String errorCode, String text, Object details){
        VpnEventChannel.logError(errorCode, text, details);
    }


    public void vpnStarted(){
        VpnEventChannel.updateVpnState(true);
        logText("VPN started!");
    }
    public void vpnStopped(){
        VpnEventChannel.updateVpnState(false);
        logText("VPN stopped!");
    }

}
