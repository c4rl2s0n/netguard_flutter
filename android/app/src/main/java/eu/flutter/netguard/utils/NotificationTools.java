package eu.flutter.netguard.utils;

import android.app.Notification;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.Context;
import android.os.Build;
import android.util.TypedValue;

import androidx.core.app.NotificationCompat;
import androidx.core.app.PendingIntentCompat;

import eu.flutter.netguard.MainActivity;
import eu.flutter.netguard.R;

public class NotificationTools {
    public static final int ENFORCING = 1;
    public static final int WAITING = 2;
    public static final int DISABLED = 3;
    public static final int LOCKDOWN = 4;
    public static final int AUTOSTART = 5;
    public static final int ERROR = 6;
    public static final int TRAFFIC = 7;
    public static final int UPDATE = 8;
    public static final int EXTERNAL = 9;
    public static final int DOWNLOAD = 10;
    private static final String CHANNEL_ID = "netguard_channel";

    private final Context context;
    public NotificationTools(Context context){
        this.context = context;
        createNotificationChannel();
    }

    private void createNotificationChannel() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            NotificationChannel channel = new NotificationChannel(
                    CHANNEL_ID,
                    "NetGuard VPN Service",
                    NotificationManager.IMPORTANCE_LOW // Low = no sound
            );
            channel.setDescription("Used to show VPN running status");

            NotificationManager manager = context.getSystemService(NotificationManager.class);
            if (manager != null) {
                manager.createNotificationChannel(channel);
            }
        }
    }

    private NotificationCompat.Builder _builderBase(){
        android.content.Intent main = new android.content.Intent(context, MainActivity.class);
        PendingIntent pi = PendingIntentCompat.getActivity(context, 0, main, PendingIntent.FLAG_UPDATE_CURRENT, false);

        return new NotificationCompat.Builder(context, CHANNEL_ID)
                .setContentIntent(pi)
                .setContentTitle("NetGuard VPN")
                .setSmallIcon(R.mipmap.ic_launcher)
                .setVisibility(NotificationCompat.VISIBILITY_PUBLIC)
                .setPriority(NotificationCompat.PRIORITY_DEFAULT)
                .setCategory(NotificationCompat.CATEGORY_SERVICE)
                .setOngoing(true)
                .setAutoCancel(false);
    }

    public Notification getRunningNotification() {
        return _builderBase()
            .setContentText("VPN is running")
            .setPriority(NotificationCompat.PRIORITY_HIGH)
            .build();
    }

    public Notification getWaitingNotification() {
        return _builderBase()
                .setContentText("VPN is ready")
                .setPriority(NotificationCompat.PRIORITY_LOW)
                .build();
    }
}
