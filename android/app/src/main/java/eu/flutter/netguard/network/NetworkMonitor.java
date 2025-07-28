package eu.flutter.netguard.network;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.IntentFilter;
import android.net.ConnectivityManager;
import android.net.NetworkCapabilities;
import android.net.NetworkRequest;
import android.os.Build;
import android.util.Log;

import androidx.core.content.ContextCompat;


public class NetworkMonitor{
    private static final String TAG = "NetGuard.Monitor";
    private final Context context;

    BroadcastReceiver connectivityChangedReceiver;
    ConnectivityManager.NetworkCallback networkMonitorCallback;
    ConnectivityManager.NetworkCallback networkChangeCallback;

    public NetworkMonitor(Context context){
        this.context = context;
    }

    public void openListener(){
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M)
            try {
                listenNetworkChanges();
            } catch (Throwable ex) {
                Log.w(TAG, ex + "\n" + Log.getStackTraceString(ex));
                listenConnectivityChanges();
            }
        else
            listenConnectivityChanges();

        listenNetworkMonitor();
    }
    public void closeListener(){
        unlistenNetworkChanges();
        unlistenConnectivityChanges();
        unlistenNetworkMonitor();
    }

    private void listenNetworkMonitor(){
        networkMonitorCallback = new NetworkMonitorCallback(context);
        // Monitor networks
        ConnectivityManager cm = (ConnectivityManager) context.getSystemService(Context.CONNECTIVITY_SERVICE);
        cm.registerNetworkCallback(
                new NetworkRequest.Builder()
                        .addCapability(NetworkCapabilities.NET_CAPABILITY_INTERNET).build(),
                networkMonitorCallback);
    }
    private void unlistenNetworkMonitor(){
        ConnectivityManager cm = (ConnectivityManager) context.getSystemService(Context.CONNECTIVITY_SERVICE);
        cm.unregisterNetworkCallback(networkMonitorCallback);

        networkMonitorCallback = null;
    }

    private void listenNetworkChanges() {
        // Listen for network changes
        Log.i(TAG, "Starting listening to network changes");
        ConnectivityManager cm = (ConnectivityManager) context.getSystemService(Context.CONNECTIVITY_SERVICE);
        NetworkRequest.Builder builder = new NetworkRequest.Builder();
        builder.addCapability(NetworkCapabilities.NET_CAPABILITY_INTERNET);
        if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.M)
            builder.addCapability(NetworkCapabilities.NET_CAPABILITY_VALIDATED);

        networkChangeCallback = new NetworkChangeCallback(context);
        cm.registerNetworkCallback(builder.build(), networkChangeCallback);
    }

    private void unlistenNetworkChanges() {
        if(networkChangeCallback == null) return;
        ConnectivityManager cm = (ConnectivityManager) context.getSystemService(Context.CONNECTIVITY_SERVICE);
        cm.unregisterNetworkCallback(networkChangeCallback);
        networkChangeCallback = null;
    }

    private void listenConnectivityChanges() {
        // Listen for connectivity updates
        connectivityChangedReceiver = new ConnectivityChangedReceiver();
        Log.i(TAG, "Starting listening to connectivity changes");
        IntentFilter ifConnectivity = new IntentFilter();
        ifConnectivity.addAction(ConnectivityManager.CONNECTIVITY_ACTION);
        ContextCompat.registerReceiver(context, connectivityChangedReceiver, ifConnectivity, ContextCompat.RECEIVER_NOT_EXPORTED);
    }
    private void unlistenConnectivityChanges(){
        if(connectivityChangedReceiver == null) return;
        context.unregisterReceiver(connectivityChangedReceiver);
        connectivityChangedReceiver = null;
    }
}