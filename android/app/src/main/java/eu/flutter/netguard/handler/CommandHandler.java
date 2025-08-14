package eu.flutter.netguard.handler;

import static eu.flutter.netguard.MyVpnService.isRunning;
import static eu.flutter.netguard.utils.WakeLock.getLock;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.os.Looper;
import android.os.Message;
import android.os.PowerManager;
import android.util.Log;

import androidx.annotation.NonNull;

import eu.flutter.netguard.data.ModelBuilder;
import eu.flutter.netguard.flutter.NativeBridge;
import eu.flutter.netguard.interfaces.VpnCommandExecutor;
import eu.flutter.netguard.utils.Values;
import eu.flutter.netguard.utils.WakeLock;


public class CommandHandler extends android.os.Handler {

    static final String TAG = "NetGuard.CommandHandler";
    public int queue = 0;

    final Context context;
    final VpnCommandExecutor commandExecutor;
    public CommandHandler( Context context, Looper looper, VpnCommandExecutor commandExecutor) {
        super(looper);
        this.context = context;
        this.commandExecutor = commandExecutor;
    }

    public void quit(){
        super.getLooper().quit();
    }


    public void queue(Intent intent) {
        synchronized (this) {
            queue++;
        }
        Message msg = obtainMessage();
        msg.obj = intent;
        sendMessage(msg);
    }

    @Override
    public void handleMessage(@NonNull Message msg) {
        try {
            synchronized (commandExecutor) {
                handleIntent((Intent) msg.obj);
            }
        } catch (Throwable ex) {
            Log.e(TAG, ex + "\n" + Log.getStackTraceString(ex));
        } finally {
            synchronized (this) {
                queue--;
            }
            try {
                PowerManager.WakeLock wl = getLock(context);
                if (wl.isHeld())
                    wl.release();
                else
                    Log.w(TAG, "Wakelock under-locked");
                Log.i(TAG, "Messages=" + hasMessages(0) + " wakelock=" + WakeLock.isHeld(context));
            } catch (Throwable ex) {
                Log.e(TAG, ex + "\n" + Log.getStackTraceString(ex));
            }
        }
    }

    private void handleIntent(Intent intent) {
        String action = intent.getAction();
        if(action == null) action = "";

        eu.flutter.netguard.utils.Log.i(TAG, "onStartCommand: "+action);

        switch (action) {
            case Values.Intent.Actions.START:
                if (isRunning(context))
                    commandExecutor.reloadVpn();
                else
                    commandExecutor.startVpn();
                break;
            case Values.Intent.Actions.RELOAD:
                commandExecutor.reloadVpn();
                break;
            case Values.Intent.Actions.STOP:
                commandExecutor.stopVpn();
                break;
            case Values.Intent.Actions.PUSH_STATS:
                Bundle bundle = intent.getExtras();
                if (bundle != null) {
                    NativeBridge.SessionStatistics sessionStatistics = ModelBuilder.SessionStatisticsFromBundle(bundle);
                    commandExecutor.updateStatsNotification(sessionStatistics);
                }
                break;
        }

    }

//    private void watchdog(Intent intent) {
//        if (vpn == null) {
//            SharedPreferences prefs = PreferenceManager.getDefaultSharedPreferences(ServiceSinkhole.this);
//            if (prefs.getBoolean("enabled", false)) {
//                Log.e(TAG, "Service was killed");
//                start();
//            }
//        }
//    }

}
