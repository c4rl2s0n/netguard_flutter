package eu.flutter.netguard.utils;


import android.content.Context;
import android.content.SharedPreferences;
import android.os.Handler;
import android.os.Looper;
import android.os.Message;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.preference.PreferenceManager;

import eu.flutter.netguard.MainActivity;
import eu.flutter.netguard.MyVpnService;
import eu.flutter.netguard.NativeBridge.*;
import eu.flutter.netguard.VpnEventChannel;
import eu.flutter.netguard.data.DatabaseHelper;

public final class LogHandler extends Handler {
    private static final String TAG = "NetGuard.LogHandler";

    private static final int MSG_STATS_START = 1;
    private static final int MSG_STATS_STOP = 2;
    private static final int MSG_STATS_UPDATE = 3;
    private static final int MSG_PACKET = 4;
    private static final int MSG_USAGE = 5;
    private static final int MSG_DNS = 6;
    public int queue = 0;

    private static final int MAX_QUEUE = 250;

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

    public void packet(Packet packet){
        Message msg = obtainMessage();
        msg.obj = packet;
        msg.what = MSG_PACKET;
        queue(msg);
    }
    public void dns(ResourceRecord record){
        Message msg = obtainMessage();
        msg.obj = record;
        msg.what = MSG_DNS;
        queue(msg);
    }
    public void domain(String name){
        Message msg = obtainMessage();
        msg.obj = name;
        msg.what = MSG_DNS;
        queue(msg);
    }
    public void account(Usage usage) {
        Message msg = obtainMessage();
        msg.obj = usage;
        msg.what = MSG_USAGE;

        queue(msg);
    }

    @Override
    public void handleMessage(Message msg) {
        try {
            switch (msg.what) {
                case MSG_PACKET:
                    VpnEventChannel.logPacket((Packet) msg.obj);
                    break;

                case MSG_DNS:
                    VpnEventChannel.logDns((ResourceRecord) msg.obj);
                    break;

                case MSG_USAGE:
                    usage((Usage) msg.obj);
                    break;

                default:
                    Log.e(TAG, "Unknown log message=" + msg.what);
            }

            synchronized (this) {
                queue--;
            }

        } catch (Throwable ex) {
            Log.e(TAG, ex.toString() + "\n" + Log.getStackTraceString(ex));
        }
    }

    public void logText(String text){
        VpnEventChannel.logText(text);
    }
    public void logError(String errorCode, String text, Object details){
        VpnEventChannel.logError(errorCode, text, details);
    }


    public void vpnStopped(){
        VpnEventChannel.updateVpnState(false);
        logText("VPN stopped!");
    }


    private void usage(Usage usage) {
        if (usage.getUid() >= 0 && !(usage.getUid() == 0 && usage.getProtocol() == Protocols.UDP && usage.getDport() == 53)) {
            SharedPreferences prefs = PreferenceManager.getDefaultSharedPreferences(context);
            boolean filter = prefs.getBoolean("filter", false);
            boolean log_app = prefs.getBoolean("log_app", false);
            boolean track_usage = prefs.getBoolean("track_usage", false);
            if (filter && log_app && track_usage) {
                DatabaseHelper dh = DatabaseHelper.getInstance(this.context);
                String dname = dh.getQName(usage.getUid(), usage.getDaddr());
                Log.i(TAG, "Usage account " + usage + " dname=" + dname);
                dh.updateUsage(usage, dname);
            }
        }
    }
}
