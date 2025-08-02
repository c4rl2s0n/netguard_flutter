package eu.flutter.netguard.network;


import android.content.Context;
import android.net.ConnectivityManager;
import android.net.LinkProperties;
import android.net.Network;
import android.net.NetworkCapabilities;
import android.os.Build;
import android.text.TextUtils;


import java.net.InetAddress;
import java.util.List;
import java.util.Objects;

import eu.flutter.netguard.MyVpnService;
import eu.flutter.netguard.utils.Log;

public class NetworkChangeCallback extends ConnectivityManager.NetworkCallback{
    private static final String TAG = "NetGuard.NetworkChange";
    private Network last_active = null;
    private Network last_network = null;
    private Boolean last_connected = null;
    private Boolean last_metered = null;
    private String last_generation = null;
    private List<InetAddress> last_dns = null;

    Context context;
    public NetworkChangeCallback(Context context){
        this.context = context;
    }

    @Override
    public void onAvailable(Network network) {
        Log.i(TAG, "Available network=" + network);
        if (!NetworkUtils.isActiveNetwork(context, network))
            return;

        last_active = network;
        last_connected = NetworkUtils.isConnected(context);
        last_metered = NetworkUtils.isMeteredNetwork(context);
        MyVpnService.reload(context, "network available");
    }

    @Override
    public void onLinkPropertiesChanged(Network network, LinkProperties linkProperties) {
        Log.i(TAG, "Changed properties=" + network + " props=" + linkProperties);
        if (!NetworkUtils.isActiveNetwork(context, network))
            return;

        // Make sure the right DNS servers are being used
        List<InetAddress> dns = linkProperties.getDnsServers();
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.O || !same(last_dns, dns)) {
            Log.i(TAG, "Changed link properties=" + linkProperties +
                    "DNS cur=" + TextUtils.join(",", dns) +
                    "DNS prv=" + (last_dns == null ? null : TextUtils.join(",", last_dns)));
            last_dns = dns;
            MyVpnService.reload(context, "link properties changed");
        }
    }

    @Override
    public void onCapabilitiesChanged(Network network, NetworkCapabilities networkCapabilities) {
        Log.i(TAG, "Changed capabilities=" + network + " caps=" + networkCapabilities);
        if (!NetworkUtils.isActiveNetwork(context,network))
            return;

        boolean connected = NetworkUtils.isConnected(context);
        boolean metered = NetworkUtils.isMeteredNetwork(context);
        String generation = NetworkUtils.getNetworkGeneration(context);
        Log.i(TAG, "Connected=" + connected + "/" + last_connected +
                " unmetered=" + metered + "/" + last_metered +
                " generation=" + generation + "/" + last_generation);

        String reason = null;

        if (!Objects.equals(network, last_network))
            reason = "Network changed";

        if (reason == null && last_connected != null && !last_connected.equals(connected))
            reason = "Connected state changed";

        if (reason == null && last_metered != null && !last_metered.equals(metered))
            reason = "Unmetered state changed";

        if (reason == null && last_generation != null && !last_generation.equals(generation)) {
//            SharedPreferences prefs = PreferenceManager.getDefaultSharedPreferences(ServiceSinkhole.this);
//            if (prefs.getBoolean("unmetered_2g", false) ||
//                    prefs.getBoolean("unmetered_3g", false) ||
//                    prefs.getBoolean("unmetered_4g", false))
            // TODO: think about reloading when network generation changes (would also need to be added to ConnectivityChanges)
                //reason = "Generation changed";
        }

        if (reason != null)
            MyVpnService.reload(context, reason);

        last_network = network;
        last_connected = connected;
        last_metered = metered;
        last_generation = generation;
    }

    @Override
    public void onLost(Network network) {
        Log.i(TAG, "Lost network=" + network + " active=" + NetworkUtils.isActiveNetwork(context, network));
        if (last_active == null || !last_active.equals(network))
            return;

        last_active = null;
        last_connected = NetworkUtils.isConnected(context);
        MyVpnService.reload(context, "network lost");
    }

    boolean same(List<InetAddress> last, List<InetAddress> current) {
        if (last == null || current == null)
            return false;
        if (last == null || last.size() != current.size())
            return false;

        for (int i = 0; i < current.size(); i++)
            if (!last.get(i).equals(current.get(i)))
                return false;

        return true;
    }
}

