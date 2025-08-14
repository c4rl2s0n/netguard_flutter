package eu.flutter.netguard.network;

import android.content.Context;
import android.net.ConnectivityManager;
import android.net.Network;
import android.net.NetworkCapabilities;
import android.net.NetworkInfo;
import android.os.Build;


import androidx.annotation.NonNull;

import java.io.IOException;
import java.net.InetSocketAddress;
import java.net.Socket;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import eu.flutter.netguard.utils.Log;

public  class NetworkMonitorCallback extends ConnectivityManager.NetworkCallback {
    private static final String TAG = "NetGuard.NetworkMonitor";
    private final Map<Network, Long> validated = new HashMap<>();

    Context context;
    public NetworkMonitorCallback(Context context){
        this.context = context;
    }

    // https://android.googlesource.com/platform/frameworks/base/+/master/services/core/java/com/android/server/connectivity/NetworkMonitor.java

    @Override
    public void onAvailable(@NonNull Network network) {
        ConnectivityManager cm = (ConnectivityManager) context.getSystemService(Context.CONNECTIVITY_SERVICE);
        NetworkInfo ni = cm.getNetworkInfo(network);
        NetworkCapabilities capabilities = cm.getNetworkCapabilities(network);
        Log.i(TAG, "Available network " + network + " " + ni);
        Log.i(TAG, "Capabilities=" + capabilities);
        checkConnectivity(network, ni, capabilities);
    }

    @Override
    public void onCapabilitiesChanged(@NonNull Network network, @NonNull NetworkCapabilities capabilities) {
        ConnectivityManager cm = (ConnectivityManager) context.getSystemService(Context.CONNECTIVITY_SERVICE);
        NetworkInfo ni = cm.getNetworkInfo(network);
        Log.i(TAG, "New capabilities network " + network + " " + ni);
        Log.i(TAG, "Capabilities=" + capabilities);
        checkConnectivity(network, ni, capabilities);
    }

    @Override
    public void onLosing(@NonNull Network network, int maxMsToLive) {
        ConnectivityManager cm = (ConnectivityManager) context.getSystemService(Context.CONNECTIVITY_SERVICE);
        NetworkInfo ni = cm.getNetworkInfo(network);
        Log.i(TAG, "Losing network " + network + " within " + maxMsToLive + " ms " + ni);
    }

    @Override
    public void onLost(@NonNull Network network) {
        ConnectivityManager cm = (ConnectivityManager) context.getSystemService(Context.CONNECTIVITY_SERVICE);
        NetworkInfo ni = cm.getNetworkInfo(network);
        Log.i(TAG, "Lost network " + network + " " + ni);

        synchronized (validated) {
            validated.remove(network);
        }
    }

    @Override
    public void onUnavailable() {
        Log.i(TAG, "No networks available");
    }

    private void checkConnectivity(Network network, NetworkInfo ni, NetworkCapabilities capabilities) {
        if (NetworkUtils.isActiveNetwork(context, network) &&
                ni != null && capabilities != null &&
                ni.getDetailedState() != NetworkInfo.DetailedState.SUSPENDED &&
                ni.getDetailedState() != NetworkInfo.DetailedState.BLOCKED &&
                ni.getDetailedState() != NetworkInfo.DetailedState.DISCONNECTED &&
                capabilities.hasCapability(NetworkCapabilities.NET_CAPABILITY_NOT_VPN) &&
                !capabilities.hasCapability(NetworkCapabilities.NET_CAPABILITY_VALIDATED)) {

            synchronized (validated) {
                if (validated.containsKey(network) &&
                        validated.get(network) + 20 * 1000 > new Date().getTime()) {
                    Log.i(TAG, "Already validated " + network + " " + ni);
                    return;
                }
            }

            // TODO: maybe make this configurable
            String host = "www.ikusa.tech";
            Log.i(TAG, "Validating " + network + " " + ni + " host=" + host);

            Socket socket = null;
            try {
                socket = network.getSocketFactory().createSocket();
                socket.connect(new InetSocketAddress(host, 443), 10000);
                Log.i(TAG, "Validated " + network + " " + ni + " host=" + host);
                synchronized (validated) {
                    validated.put(network, new Date().getTime());
                }
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                    ConnectivityManager cm = (ConnectivityManager) context.getSystemService(Context.CONNECTIVITY_SERVICE);
                    cm.reportNetworkConnectivity(network, true);
                    Log.i(TAG, "Reported " + network + " " + ni);
                }
            } catch (IOException ex) {
                Log.e(TAG, ex.toString());
                Log.i(TAG, "No connectivity " + network + " " + ni);
            } finally {
                if (socket != null)
                    try {
                        socket.close();
                    } catch (IOException ex) {
                        Log.e(TAG, ex.toString() + "\n" + Log.getStackTraceString(ex));
                    }
            }
        }
    }

}

