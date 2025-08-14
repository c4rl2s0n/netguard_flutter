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

import static java.lang.Math.log10;

import android.content.Context;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.drawable.BitmapDrawable;
import android.graphics.drawable.Drawable;
import android.os.Handler;
import android.os.Looper;

import androidx.annotation.ColorRes;

import java.io.ByteArrayOutputStream;
import java.text.DecimalFormat;

public class Util {
    private static final String TAG = "NetGuard.Util";

    private static native void dump_memory_profile();

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


    public static void runOnUiThread(Runnable runnable){
        new Handler(Looper.getMainLooper()).post(runnable);
    }

    public static int getColor(Context context, @ColorRes int id){
        return context.getResources().getColor(id);
    }
    public static int dips2pixels(int dips, Context context) {
        return Math.round(dips * context.getResources().getDisplayMetrics().density + 0.5f);
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


    public static long packageNameToUid(Context context, String packageName){
        long uid = -1;
        try {
            uid = context.getPackageManager().getApplicationInfo(packageName, 0).uid;
        } catch (PackageManager.NameNotFoundException ignored) {}
        return uid;
    }


    public static String readableFileSize(long size, boolean base1024) {
        if (size <= 0) return "0";

        final int base = base1024 ? 1024 : 1000;
        final String[] units = base1024
                ? new String[]{"Bi", "KiB", "MiB", "GiB", "TiB"}
        : new String[]{"B", "kB", "MB", "GB", "TB"};

        int digitGroups = (int) (log10(size) / log10(base));
        double value = size / Math.pow(base, digitGroups);
        return new DecimalFormat("#,##0.#").format(value) + " " +units[digitGroups];
    }

    // Optional overload for convenience
    public static String readableFileSize(long size) {
        return readableFileSize(size, false); // Default to base 1000
    }
}
