package eu.flutter.netguard.utils;

/*
    This file is part of NetGuard.

    NetGuard is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    NetGuard is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with NetGuard.  If not, see <http://www.gnu.org/licenses/>.

    Copyright 2015-2024 by Marcel Bokhorst (M66B)
*/

import android.Manifest;
import android.content.Context;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.res.Resources;
import android.database.Cursor;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Canvas;
import android.graphics.drawable.BitmapDrawable;
import android.graphics.drawable.Drawable;
import android.net.ConnectivityManager;
import android.net.LinkProperties;
import android.net.Network;
import android.net.NetworkInfo;
import android.net.wifi.WifiManager;
import android.os.Build;
import android.os.Bundle;
import android.os.PowerManager;
import android.provider.Settings;
import android.telephony.TelephonyManager;
import android.text.TextUtils;
import android.util.Log;

import androidx.core.net.ConnectivityManagerCompat;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.net.InetAddress;
import java.security.MessageDigest;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Set;

import eu.flutter.netguard.NativeBridge.*;

public class Util {
    private static final String TAG = "NetGuard.Util";

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

    private static native String jni_getprop(String name);

    private static native boolean is_numeric_address(String ip);

    private static native void dump_memory_profile();
//
//    static {
//        try {
//            System.loadLibrary("netguard");
//        } catch (UnsatisfiedLinkError ignored) {
//            System.exit(1);
//        }
//    }

    public static String getSelfVersionName(Context context) {
        try {
            PackageInfo pInfo = context.getPackageManager().getPackageInfo(context.getPackageName(), 0);
            return pInfo.versionName;
        } catch (PackageManager.NameNotFoundException ex) {
            return ex.toString();
        }
    }

    public static int getSelfVersionCode(Context context) {
        try {
            PackageInfo pInfo = context.getPackageManager().getPackageInfo(context.getPackageName(), 0);
            return pInfo.versionCode;
        } catch (PackageManager.NameNotFoundException ex) {
            return -1;
        }
    }

    public static boolean isNetworkActive(Context context) {
        ConnectivityManager cm = (ConnectivityManager) context.getSystemService(Context.CONNECTIVITY_SERVICE);
        return (cm != null && cm.getActiveNetworkInfo() != null);
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

    public static boolean isPrivateDns(Context context) {
        String dns_mode = Settings.Global.getString(context.getContentResolver(), "private_dns_mode");
        Log.i(TAG, "Private DNS mode=" + dns_mode);
        if (dns_mode == null)
            dns_mode = "off";
        return (!"off".equals(dns_mode));
    }

    public static String getPrivateDnsSpecifier(Context context) {
        String dns_mode = Settings.Global.getString(context.getContentResolver(), "private_dns_mode");
        if ("hostname".equals(dns_mode))
            return Settings.Global.getString(context.getContentResolver(), "private_dns_specifier");
        else
            return null;
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

    public static boolean hasPhoneStatePermission(Context context) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M)
            return (context.checkSelfPermission(Manifest.permission.READ_PHONE_STATE) == PackageManager.PERMISSION_GRANTED);
        else
            return true;
    }

    public static List<String> getDefaultDNS(Context context) {
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

    public static boolean isNumericAddress(String ip) {
        return is_numeric_address(ip);
    }

    public static boolean isInteractive(Context context) {
        PowerManager pm = (PowerManager) context.getSystemService(Context.POWER_SERVICE);
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.KITKAT_WATCH)
            return (pm != null && pm.isScreenOn());
        else
            return (pm != null && pm.isInteractive());
    }

    public static boolean isPackageInstalled(String packageName, Context context) {
        try {
            context.getPackageManager().getPackageInfo(packageName, 0);
            return true;
        } catch (PackageManager.NameNotFoundException ignored) {
            return false;
        }
    }

    public static boolean isSystem(int uid, Context context) {
        PackageManager pm = context.getPackageManager();
        String[] pkgs = pm.getPackagesForUid(uid);
        if (pkgs != null)
            for (String pkg : pkgs)
                if (isSystem(pkg, context))
                    return true;
        return false;
    }

    public static boolean isSystem(String packageName, Context context) {
        try {
            PackageManager pm = context.getPackageManager();
            PackageInfo info = pm.getPackageInfo(packageName, 0);
            return ((info.applicationInfo.flags & (ApplicationInfo.FLAG_SYSTEM | ApplicationInfo.FLAG_UPDATED_SYSTEM_APP)) != 0);
            /*
            PackageInfo pkg = pm.getPackageInfo(packageName, PackageManager.GET_SIGNATURES);
            PackageInfo sys = pm.getPackageInfo("android", PackageManager.GET_SIGNATURES);
            return (pkg != null && pkg.signatures != null && pkg.signatures.length > 0 &&
                    sys.signatures.length > 0 && sys.signatures[0].equals(pkg.signatures[0]));
            */
        } catch (PackageManager.NameNotFoundException ignore) {
            return false;
        }
    }

    public static boolean hasInternet(String packageName, Context context) {
        PackageManager pm = context.getPackageManager();
        return (pm.checkPermission("android.permission.INTERNET", packageName) == PackageManager.PERMISSION_GRANTED);
    }

    public static boolean hasInternet(int uid, Context context) {
        PackageManager pm = context.getPackageManager();
        String[] pkgs = pm.getPackagesForUid(uid);
        if (pkgs != null)
            for (String pkg : pkgs)
                if (hasInternet(pkg, context))
                    return true;
        return false;
    }

    public static boolean isEnabled(PackageInfo info, Context context) {
        int setting;
        try {
            PackageManager pm = context.getPackageManager();
            setting = pm.getApplicationEnabledSetting(info.packageName);
        } catch (IllegalArgumentException ex) {
            setting = PackageManager.COMPONENT_ENABLED_STATE_DEFAULT;
            Log.w(TAG, ex.toString() + "\n" + Log.getStackTraceString(ex));
        }
        if (setting == PackageManager.COMPONENT_ENABLED_STATE_DEFAULT)
            return info.applicationInfo.enabled;
        else
            return (setting == PackageManager.COMPONENT_ENABLED_STATE_ENABLED);
    }

    public static List<String> getApplicationNames(int uid, Context context) {
        List<String> listResult = new ArrayList<>();
        if (uid == 0)
            listResult.add("Title Root"); // context.getString(R.string.title_root)
        else if (uid == 1013)
            listResult.add("Title Mediaserver"); // context.getString(R.string.title_mediaserver)
        else if (uid == 9999)
            listResult.add("Title Nobody"); // context.getString(R.string.title_nobody)
        else {
            PackageManager pm = context.getPackageManager();
            String[] pkgs = pm.getPackagesForUid(uid);
            if (pkgs != null)
                for (String pkg : pkgs)
                    try {
                        ApplicationInfo info = pm.getApplicationInfo(pkg, 0);
                        String name = pm.getApplicationLabel(info).toString();
                        if (!TextUtils.isEmpty(name))
                            listResult.add(name);
                    } catch (PackageManager.NameNotFoundException ignored) {
                    }
            Collections.sort(listResult);
        }
        return listResult;
    }

    public static boolean canFilter(Context context) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q)
            return true;

        // https://android-review.googlesource.com/#/c/206710/1/untrusted_app.te
        File tcp = new File("/proc/net/tcp");
        File tcp6 = new File("/proc/net/tcp6");
        try {
            if (tcp.exists() && tcp.canRead())
                return true;
        } catch (SecurityException ignored) {
        }
        try {
            return (tcp6.exists() && tcp6.canRead());
        } catch (SecurityException ignored) {
            return false;
        }
    }


    public static String getFingerprint(Context context) {
        try {
            PackageManager pm = context.getPackageManager();
            String pkg = context.getPackageName();
            PackageInfo info = pm.getPackageInfo(pkg, PackageManager.GET_SIGNATURES);
            byte[] cert = info.signatures[0].toByteArray();
            MessageDigest digest = MessageDigest.getInstance("SHA1");
            byte[] bytes = digest.digest(cert);
            StringBuilder sb = new StringBuilder();
            for (byte b : bytes)
                sb.append(Integer.toString(b & 0xff, 16).toLowerCase());
            return sb.toString();
        } catch (Throwable ex) {
            Log.e(TAG, ex.toString() + "\n" + Log.getStackTraceString(ex));
            return null;
        }
    }



    public static int dips2pixels(int dips, Context context) {
        return Math.round(dips * context.getResources().getDisplayMetrics().density + 0.5f);
    }

    private static int calculateInSampleSize(
            BitmapFactory.Options options, int reqWidth, int reqHeight) {
        int height = options.outHeight;
        int width = options.outWidth;
        int inSampleSize = 1;

        if (height > reqHeight || width > reqWidth) {
            int halfHeight = height / 2;
            int halfWidth = width / 2;

            while (halfHeight / inSampleSize >= reqHeight && halfWidth / inSampleSize >= reqWidth)
                inSampleSize *= 2;
        }

        return inSampleSize;
    }
    public static byte[] drawableToByteArray(Drawable drawable) {
        if (drawable == null)
            return null;

        Bitmap bitmap;

        if (drawable instanceof BitmapDrawable) {
            bitmap = ((BitmapDrawable) drawable).getBitmap();
        } else {
            int width = drawable.getIntrinsicWidth() > 0 ? drawable.getIntrinsicWidth() : 1;
            int height = drawable.getIntrinsicHeight() > 0 ? drawable.getIntrinsicHeight() : 1;
            bitmap = Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888);
            Canvas canvas = new Canvas(bitmap);
            drawable.setBounds(0, 0, canvas.getWidth(), canvas.getHeight());
            drawable.draw(canvas);
        }

        ByteArrayOutputStream stream = new ByteArrayOutputStream();
        bitmap.compress(Bitmap.CompressFormat.PNG, 100, stream);
        return stream.toByteArray();
    }

    public static Bitmap decodeSampledBitmapFromResource(
            Resources resources, int resourceId, int reqWidth, int reqHeight) {

        BitmapFactory.Options options = new BitmapFactory.Options();
        options.inJustDecodeBounds = true;
        BitmapFactory.decodeResource(resources, resourceId, options);
        options.inSampleSize = calculateInSampleSize(options, reqWidth, reqHeight);
        options.inJustDecodeBounds = false;

        return BitmapFactory.decodeResource(resources, resourceId, options);
    }

    public static String getProtocolName(int protocol, int version, boolean brief) {
        // https://en.wikipedia.org/wiki/List_of_IP_protocol_numbers
        String p = null;
        String b = null;
        switch (protocol) {
            case 0:
                p = "HOPO";
                b = "H";
                break;
            case 2:
                p = "IGMP";
                b = "G";
                break;
            case 1:
            case 58:
                p = "ICMP";
                b = "I";
                break;
            case 6:
                p = "TCP";
                b = "T";
                break;
            case 17:
                p = "UDP";
                b = "U";
                break;
            case 50:
                p = "ESP";
                b = "E";
                break;
        }
        if (p == null)
            return Integer.toString(protocol) + "/" + version;
        return ((brief ? b : p) + (version > 0 ? version : ""));
    }

    public static void logBundle(Bundle data) {
        if (data != null) {
            Set<String> keys = data.keySet();
            StringBuilder stringBuilder = new StringBuilder();
            for (String key : keys) {
                Object value = data.get(key);
                stringBuilder.append(key)
                        .append("=")
                        .append(value)
                        .append(value == null ? "" : " (" + value.getClass().getSimpleName() + ")")
                        .append("\r\n");
            }
            Log.d(TAG, stringBuilder.toString());
        }
    }

    private static StringBuilder getTrafficLog(Context context) {
        StringBuilder sb = new StringBuilder();

        try (Cursor cursor = eu.flutter.netguard.data.DatabaseHelper.getInstance(context).getLog(true, true, true, true, true)) {

            int colTime = cursor.getColumnIndex("time");
            int colVersion = cursor.getColumnIndex("version");
            int colProtocol = cursor.getColumnIndex("protocol");
            int colFlags = cursor.getColumnIndex("flags");
            int colSAddr = cursor.getColumnIndex("saddr");
            int colSPort = cursor.getColumnIndex("sport");
            int colDAddr = cursor.getColumnIndex("daddr");
            int colDPort = cursor.getColumnIndex("dport");
            int colDName = cursor.getColumnIndex("dname");
            int colUid = cursor.getColumnIndex("uid");
            int colData = cursor.getColumnIndex("data");
            int colAllowed = cursor.getColumnIndex("allowed");
            int colConnection = cursor.getColumnIndex("connection");
            int colInteractive = cursor.getColumnIndex("interactive");

            DateFormat format = SimpleDateFormat.getDateTimeInstance();

            int count = 0;
            while (cursor.moveToNext() && ++count < 250) {
                sb.append(format.format(cursor.getLong(colTime)));
                sb.append(" v").append(cursor.getInt(colVersion));
                sb.append(" p").append(cursor.getInt(colProtocol));
                sb.append(' ').append(cursor.getString(colFlags));
                sb.append(' ').append(cursor.getString(colSAddr));
                sb.append('/').append(cursor.getInt(colSPort));
                sb.append(" > ").append(cursor.getString(colDAddr));
                sb.append('/').append(cursor.getString(colDName));
                sb.append('/').append(cursor.getInt(colDPort));
                sb.append(" u").append(cursor.getInt(colUid));
                sb.append(" a").append(cursor.getInt(colAllowed));
                sb.append(" c").append(cursor.getInt(colConnection));
                sb.append(" i").append(cursor.getInt(colInteractive));
                sb.append(' ').append(cursor.getString(colData));
                sb.append("\r\n");
            }
        }

        return sb;
    }

    public static long packageNameToUid(Context context, String packageName){
        long uid = -1;
        try {
            uid = context.getPackageManager().getApplicationInfo(packageName, 0).uid;
        } catch (PackageManager.NameNotFoundException ignored) {}
        return uid;
    }

}
