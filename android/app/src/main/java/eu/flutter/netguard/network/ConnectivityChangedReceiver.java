package eu.flutter.netguard.network;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.net.ConnectivityManager;
import android.util.Log;

import eu.flutter.netguard.MyVpnService;

public class ConnectivityChangedReceiver extends BroadcastReceiver {
    private static final String TAG = "NetGuard.ConnectChanged";
    @Override
    public void onReceive(Context context, Intent intent) {
        // Filter VPN connectivity changes
        int networkType = intent.getIntExtra(ConnectivityManager.EXTRA_NETWORK_TYPE, ConnectivityManager.TYPE_DUMMY);
        if (networkType == ConnectivityManager.TYPE_VPN)
            return;

        // Reload rules
        Log.i(TAG, "Received " + intent);
        MyVpnService.reload(context, "connectivity changed");
    }
}
