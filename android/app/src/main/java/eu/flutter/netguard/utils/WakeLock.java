package eu.flutter.netguard.utils;

import android.content.Context;
import android.os.PowerManager;

import eu.flutter.netguard.R;

public class WakeLock {

    private static volatile PowerManager.WakeLock wlInstance = null;
    synchronized public static PowerManager.WakeLock getLock(Context context) {
        if (wlInstance == null) {
            PowerManager pm = (PowerManager) context.getSystemService(Context.POWER_SERVICE);
            wlInstance = pm.newWakeLock(PowerManager.PARTIAL_WAKE_LOCK, context.getString(R.string.app_name) + " wakelock");
            wlInstance.setReferenceCounted(true);
        }
        return wlInstance;
    }
    synchronized public static boolean isHeld(Context context){
        return getLock(context).isHeld();
    }

    synchronized public static void releaseLock(Context context) {
        if (wlInstance != null) {
            while (wlInstance.isHeld())
                wlInstance.release();
            wlInstance = null;
        }
    }
}
