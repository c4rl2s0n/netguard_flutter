package eu.flutter.netguard.utils;

import android.app.Notification;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.Context;
import android.os.Build;
import android.widget.RemoteViews;

import androidx.core.app.NotificationCompat;
import androidx.core.app.PendingIntentCompat;

import java.util.HashMap;
import java.util.Map;

import eu.flutter.netguard.activities.MainActivity;
import eu.flutter.netguard.flutter.NativeBridge;
import eu.flutter.netguard.R;
import eu.flutter.netguard.data.StatusNotificationData;

public class NotificationTools {
    public static final int RUNNING = 1;
    public static final int WAITING = 2;
    public static final int STATS = 3;
    private static final String CHANNEL_ID = "netguard_channel";

    private final Context context;
    public NotificationTools(Context context){
        this.context = context;
        createNotificationChannel();

        mNotificationManager = (NotificationManager) context.getSystemService(Context.NOTIFICATION_SERVICE);
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
    private final NotificationManager mNotificationManager;

    //Some things we only have to set the first time.
    private final Map<Integer, NotificationCompat.Builder> mBuilder = new HashMap<>();

    private void updateNotification(int notificationId, NotificationCompat.Builder builder) {
        mNotificationManager.notify(notificationId, builder.build());
    }
    private void dismissNotification(int notificationId) {
        mNotificationManager.cancel(notificationId);
    }

    private NotificationCompat.Builder _builderBase(int notificationId){
        android.content.Intent main = new android.content.Intent(context, MainActivity.class);
        PendingIntent pi = PendingIntentCompat.getActivity(context, 0, main, PendingIntent.FLAG_UPDATE_CURRENT, false);

        if(!mBuilder.containsKey(notificationId)){
            NotificationCompat.Builder builder = new NotificationCompat.Builder(context, CHANNEL_ID)
                    .setContentIntent(pi)
                    .setContentTitle("NetGuard VPN")
                    .setSmallIcon(R.mipmap.ic_launcher)
                    .setVisibility(NotificationCompat.VISIBILITY_PUBLIC)
                    .setPriority(NotificationCompat.PRIORITY_DEFAULT)
                    .setCategory(NotificationCompat.CATEGORY_SERVICE)
                    .setAutoCancel(false);
            mBuilder.put(notificationId, builder);
        }
        return mBuilder.get(notificationId);
    }

    public Notification getRunningNotification() {
        return _builderBase(RUNNING)
            .setContentText("Firewall is active")
            .setPriority(NotificationCompat.PRIORITY_HIGH)
            .setOngoing(true)
            .build();
    }

    public void hideStatsNotification(){
        dismissNotification(STATS);
    }
    public void updateStatsNotification(NativeBridge.SessionStatistics sessionStatistics) {
        StatusNotificationData notificationData = new StatusNotificationData(context, context.getString(R.string.app_name), sessionStatistics);
        var builder = _builderBase(STATS);
        builder.setOnlyAlertOnce(true)
               .setOngoing(false)
               .setContentTitle(notificationData.getTitle())
               .setContentText("Packets blocked: " + notificationData.getPacketCountBlocked() + " / " + notificationData.getPacketCountTotal())
               .setCustomContentView(prepareStatusNotificationViewSmall(notificationData))
               .setCustomBigContentView(prepareStatusNotificationViewLarge(notificationData))
               .setNumber((int)notificationData.getPacketCountBlocked())
               .setStyle(new NotificationCompat.DecoratedCustomViewStyle())
               .setPriority(NotificationCompat.PRIORITY_HIGH);
        updateNotification(STATS, builder);
    }

    public Notification getWaitingNotification() {
        return _builderBase(WAITING)
                .setContentText("VPN is ready")
                .setPriority(NotificationCompat.PRIORITY_LOW)
                .build();
    }


    private RemoteViews prepareStatusNotificationViewSmall(StatusNotificationData notificationData){
        RemoteViews view = new RemoteViews(context.getPackageName(), R.layout.status_small);
        view.setTextViewText(R.id.tvPacketCount, Long.toString(notificationData.getPacketCountTotal()));
        view.setTextViewText(R.id.tvPacketsBlocked, Long.toString(notificationData.getPacketCountBlocked()));
        view.setImageViewBitmap(R.id.ivChart, notificationData.getChart());
        return view;
    }
    private RemoteViews prepareStatusNotificationViewLarge(StatusNotificationData notificationData){
        RemoteViews view = new RemoteViews(context.getPackageName(), R.layout.status_large);
        view.setTextViewText(R.id.tvTitle, notificationData.getTitle());
        view.setTextViewText(R.id.tvPacketCount, "Packets (total): " + notificationData.getPacketCountTotal());
        view.setTextViewText(R.id.tvPacketsBlocked, "Packets (blocked): " + notificationData.getPacketCountBlocked());
        view.setImageViewBitmap(R.id.ivChart, notificationData.getChart());
        return view;
    }

}
