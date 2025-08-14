package eu.flutter.netguard.handler;


import android.content.Context;
import android.os.Handler;
import android.os.Looper;
import android.os.Message;


import androidx.annotation.NonNull;

import eu.flutter.netguard.data.ErrorMessage;
import eu.flutter.netguard.flutter.NativeBridge.*;
import eu.flutter.netguard.flutter.VpnEventChannel;
import eu.flutter.netguard.utils.Log;

public final class LogHandler extends Handler {
    private static final String TAG = "NetGuard.LogHandler";

    private static final int MSG_TRAFFIC = 1;
    private static final int MSG_TEXT = 2;
    private static final int MSG_ERROR = 3;
    private static final int MSG_START = 4;
    private static final int MSG_STOP = 5;
    public int queue = 0;

    private static final int MAX_QUEUE = 250;

    Context context;

    public LogHandler(Context context, Looper looper) {
        super(looper);
        this.context = context;
    }

    public void quit(){
        super.getLooper().quit();
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
    public void message(String message){
        Message msg = obtainMessage();
        msg.obj = message;
        msg.what = MSG_TEXT;
        queue(msg);
    }
    public void error(String errorCode, String text, Object details){
        Message msg = obtainMessage();
        msg.obj = new ErrorMessage(errorCode, text, details);
        msg.what = MSG_ERROR;
        queue(msg);
    }
    public void vpnStarted(){
        Message msg = obtainMessage();
        msg.obj = null;
        msg.what = MSG_START;
        queue(msg);
    }
    public void vpnStopped(){
        Message msg = obtainMessage();
        msg.obj = null;
        msg.what = MSG_STOP;
        queue(msg);
    }

    @Override
    public void handleMessage(@NonNull Message msg) {
        try {
            switch (msg.what) {
                case MSG_TRAFFIC:
                    VpnEventChannel.logTraffic((TrafficLog) msg.obj);
                    break;
                case MSG_TEXT:
                    VpnEventChannel.logText((String) msg.obj);
                    break;
                case MSG_ERROR:
                    ErrorMessage error = (ErrorMessage) msg.obj;
                    VpnEventChannel.logError(error.errorCode, error.text, error.details);
                    break;
                case MSG_START:
                    VpnEventChannel.updateVpnState(true);
                    break;
                case MSG_STOP:
                    VpnEventChannel.updateVpnState(false);
                    break;

                default:
                    Log.e(TAG, "Unknown log message=" + msg.what);
            }
            synchronized (this) {
                queue--;
            }
        } catch (Throwable ex) {
            Log.e(TAG, ex + "\n" + Log.getStackTraceString(ex));
        }
    }

}
