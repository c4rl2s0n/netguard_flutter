package eu.flutter.netguard.network;

import android.content.Context;
import android.net.ConnectivityManager;
import android.net.LinkProperties;
import android.net.Network;
import android.net.NetworkCapabilities;
import android.net.NetworkInfo;
import android.net.wifi.WifiManager;
import android.os.Build;
import android.telephony.TelephonyManager;
import android.util.Log;

import androidx.core.net.ConnectivityManagerCompat;

import java.net.Inet4Address;
import java.net.InetAddress;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class NetworkUtils {
    private static final String TAG = "NetGuard.NetworkUtils";

    private static native String jni_getprop(String name);
    private static native boolean is_numeric_address(String ip);

    // Roam like at home
    private static final List<String> listEU = Arrays.asList(
            "AT", // Austria
            "BE", // Belgium
            "BG", // Bulgaria
            "HR", // Croatia
            "CY", // Cyprus
            "CZ", // Czech Republic
            "DK", // Denmark
            "EE", // Estonia
            "FI", // Finland
            "FR", // France
            "DE", // Germany
            "GR", // Greece
            "HU", // Hungary
            "IS", // Iceland
            "IE", // Ireland
            "IT", // Italy
            "LV", // Latvia
            "LI", // Liechtenstein
            "LT", // Lithuania
            "LU", // Luxembourg
            "MT", // Malta
            "NL", // Netherlands
            "NO", // Norway
            "PL", // Poland
            "PT", // Portugal
            "RO", // Romania
            "SK", // Slovakia
            "SI", // Slovenia
            "ES", // Spain
            "SE" // Sweden
    );
    public static Network getActiveNetwork(Context context) {
        ConnectivityManager cm = (ConnectivityManager) context.getSystemService(Context.CONNECTIVITY_SERVICE);
        if (cm == null)
            return null;

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            Network active = cm.getActiveNetwork();
            if (active == null) {
                Log.i(TAG, "getActiveNetwork: no active network");
                return null;
            }

            NetworkCapabilities caps = cm.getNetworkCapabilities(active);
            if (caps != null && caps.hasCapability(NetworkCapabilities.NET_CAPABILITY_NOT_VPN))
                return active;
            else
                Log.w(TAG, "getActiveNetwork: active network is VPN");

        }

        NetworkInfo ani = cm.getActiveNetworkInfo();
        if (ani == null)
            return null;

        Network[] networks = cm.getAllNetworks();
        for (Network network : networks) {
            NetworkCapabilities caps = cm.getNetworkCapabilities(network);
            Log.i(TAG, "getActiveNetwork: network=" + network + " caps=" + caps);
            if (caps == null || !caps.hasCapability(NetworkCapabilities.NET_CAPABILITY_NOT_VPN))
                continue;

            NetworkInfo ni = cm.getNetworkInfo(network);
            if (ni == null)
                continue;
            if (ni.getType() == ani.getType() &&
                    ni.getSubtype() == ani.getSubtype()) {
                Log.i(TAG, "getActiveNetwork: returning network=" + network);
                return network;
            }
        }

        Log.i(TAG, "getActiveNetwork: no active network found");
        return null;
    }
    public static boolean isActiveNetwork(Context context, Network network) {
        return (network != null && network.equals(getActiveNetwork(context)));
    }


    public static boolean isConnected(Context context) {
        ConnectivityManager cm = (ConnectivityManager) context.getSystemService(Context.CONNECTIVITY_SERVICE);
        if (cm == null)
            return false;

        NetworkInfo ni = cm.getActiveNetworkInfo();
        if (ni != null && ni.isConnected())
            return true;

        Network[] networks = cm.getAllNetworks();
        if (networks == null)
            return false;

        for (Network network : networks) {
            ni = cm.getNetworkInfo(network);
            if (ni != null && ni.getType() != ConnectivityManager.TYPE_VPN && ni.isConnected())
                return true;
        }

        return false;
    }

    public static boolean isWifiActive(Context context) {
        ConnectivityManager cm = (ConnectivityManager) context.getSystemService(Context.CONNECTIVITY_SERVICE);
        NetworkInfo ni = (cm == null ? null : cm.getActiveNetworkInfo());
        return (ni != null && ni.getType() == ConnectivityManager.TYPE_WIFI);
    }

    public static boolean isMeteredNetwork(Context context) {
        ConnectivityManager cm = (ConnectivityManager) context.getSystemService(Context.CONNECTIVITY_SERVICE);
        return (cm != null && ConnectivityManagerCompat.isActiveNetworkMetered(cm));
    }

    public static String getWifiSSID(Context context) {
        WifiManager wm = (WifiManager) context.getApplicationContext().getSystemService(Context.WIFI_SERVICE);
        String ssid = (wm == null ? null : wm.getConnectionInfo().getSSID());
        return (ssid == null ? "NULL" : ssid);
    }

    public static int getNetworkType(Context context) {
        ConnectivityManager cm = (ConnectivityManager) context.getSystemService(Context.CONNECTIVITY_SERVICE);
        NetworkInfo ni = (cm == null ? null : cm.getActiveNetworkInfo());
        return (ni == null ? TelephonyManager.NETWORK_TYPE_UNKNOWN : ni.getSubtype());
    }

    public static String getNetworkGeneration(Context context) {
        ConnectivityManager cm = (ConnectivityManager) context.getSystemService(Context.CONNECTIVITY_SERVICE);
        NetworkInfo ni = cm.getActiveNetworkInfo();
        return (ni != null && ni.getType() == ConnectivityManager.TYPE_MOBILE ? getNetworkGeneration(ni.getSubtype()) : null);
    }

    public static String getNetworkGeneration(int networkType) {
        switch (networkType) {
            case TelephonyManager.NETWORK_TYPE_1xRTT:
            case TelephonyManager.NETWORK_TYPE_CDMA:
            case TelephonyManager.NETWORK_TYPE_EDGE:
            case TelephonyManager.NETWORK_TYPE_GPRS:
            case TelephonyManager.NETWORK_TYPE_IDEN:
            case TelephonyManager.NETWORK_TYPE_GSM:
                return "2G";

            case TelephonyManager.NETWORK_TYPE_EHRPD:
            case TelephonyManager.NETWORK_TYPE_EVDO_0:
            case TelephonyManager.NETWORK_TYPE_EVDO_A:
            case TelephonyManager.NETWORK_TYPE_EVDO_B:
            case TelephonyManager.NETWORK_TYPE_HSDPA:
            case TelephonyManager.NETWORK_TYPE_HSPA:
            case TelephonyManager.NETWORK_TYPE_HSPAP:
            case TelephonyManager.NETWORK_TYPE_HSUPA:
            case TelephonyManager.NETWORK_TYPE_UMTS:
            case TelephonyManager.NETWORK_TYPE_TD_SCDMA:
                return "3G";

            case TelephonyManager.NETWORK_TYPE_LTE:
            case TelephonyManager.NETWORK_TYPE_IWLAN:
                return "4G";

            default:
                return "?G";
        }
    }

    public static boolean isRoaming(Context context) {
        ConnectivityManager cm = (ConnectivityManager) context.getSystemService(Context.CONNECTIVITY_SERVICE);
        NetworkInfo ni = (cm == null ? null : cm.getActiveNetworkInfo());
        return (ni != null && ni.isRoaming());
    }

    public static boolean isNational(Context context) {
        try {
            TelephonyManager tm = (TelephonyManager) context.getSystemService(Context.TELEPHONY_SERVICE);
            return (tm != null && tm.getSimCountryIso() != null && tm.getSimCountryIso().equals(tm.getNetworkCountryIso()));
        } catch (Throwable ignored) {
            return false;
        }
    }

    public static boolean isEU(Context context) {
        try {
            TelephonyManager tm = (TelephonyManager) context.getSystemService(Context.TELEPHONY_SERVICE);
            return (tm != null && isEU(tm.getSimCountryIso()) && isEU(tm.getNetworkCountryIso()));
        } catch (Throwable ignored) {
            return false;
        }
    }

    public static boolean isEU(String country) {
        return (country != null && listEU.contains(country.toUpperCase()));
    }


    public static List<String> getDefaultDnsStrings(Context context) {
        List<String> listDns = new ArrayList<>();

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            ConnectivityManager cm = (ConnectivityManager) context.getSystemService(Context.CONNECTIVITY_SERVICE);
            Network an = cm.getActiveNetwork();
            if (an != null) {
                LinkProperties lp = cm.getLinkProperties(an);
                if (lp != null) {
                    List<InetAddress> dns = lp.getDnsServers();
                    if (dns != null)
                        for (InetAddress d : dns) {
                            Log.i(TAG, "DNS from LP: " + d.getHostAddress());
                            listDns.add(d.getHostAddress().split("%")[0]);
                        }
                }
            }
        } else {
            String dns1 = jni_getprop("net.dns1");
            String dns2 = jni_getprop("net.dns2");
            if (dns1 != null)
                listDns.add(dns1.split("%")[0]);
            if (dns2 != null)
                listDns.add(dns2.split("%")[0]);
        }

        return listDns;
    }
    public static List<InetAddress> getDefaultDns(Context context){
        List<InetAddress> listDns = new ArrayList<>();
        for (String def_dns : getDefaultDnsStrings(context))
            try {
                InetAddress ddns = InetAddress.getByName(def_dns);
                if (!(ddns.isLoopbackAddress() || ddns.isAnyLocalAddress()))
                    listDns.add(ddns);
            } catch (Throwable ex) {
                Log.e(TAG, ex + "\n" + Log.getStackTraceString(ex));
            }
        return listDns;
    }

    public static boolean isNumericAddress(String ip) {
        return is_numeric_address(ip);
    }

    public static String cleanDomain(String domain) {
        if(domain.startsWith("www.")){
            return domain.substring(4);
        }
        return domain;
    }

}
