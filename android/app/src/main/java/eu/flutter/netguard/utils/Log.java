package eu.flutter.netguard.utils;

public class Log {
    public static final int VERBOSE = 2;
    public static final int DEBUG = 3;
    public static final int INFO = 4;
    public static final int WARN = 5;
    public static final int ERROR = 6;
    public static final int NONE = 7;

    private static int currentLogLevel = DEBUG;

    public static void setLogLevel(int level) {
        currentLogLevel = Math.max(0, Math.min(Log.NONE, level));
    }

    
    public static void v(String tag, String msg) {
         if(currentLogLevel <= VERBOSE) android.util.Log.v(tag, msg);
    }

    
    public static void v(String tag, String msg, Throwable tr) {
        if(currentLogLevel <= VERBOSE) android.util.Log.v(tag, msg, tr);
    }

    
    public static void d(String tag, String msg) {
        if(currentLogLevel <= DEBUG) android.util.Log.d(tag, msg);
    }

    
    public static void d(String tag, String msg, Throwable tr) {
        if(currentLogLevel <= DEBUG) android.util.Log.d(tag, msg, tr);
    }

    
    public static void i(String tag, String msg) {
        if(currentLogLevel <= INFO) android.util.Log.i(tag, msg);
    }

    
    public static void i(String tag, String msg, Throwable tr) {
        if(currentLogLevel <= INFO) android.util.Log.i(tag, msg, tr);
    }

    
    public static void w(String tag, String msg) {
        if(currentLogLevel <= WARN) android.util.Log.w(tag, msg);
    }

    
    public static void w(String tag, String msg, Throwable tr) {
        if(currentLogLevel <= WARN) android.util.Log.w(tag, msg, tr);
    }

    
    public static void w(String tag, Throwable tr) {
        if(currentLogLevel <= WARN) android.util.Log.w(tag, tr);
    }

    
    public static void e(String tag, String msg) {
        if(currentLogLevel <= ERROR) android.util.Log.e(tag, msg);
    }

    
    public static void e(String tag, String msg, Throwable tr) {
        if(currentLogLevel <= ERROR) android.util.Log.e(tag, msg, tr);
    }

    
    public static void wtf(String tag, String msg) {
        android.util.Log.wtf(tag, msg);
    }

    
    public static void wtf(String tag, Throwable tr) {
        android.util.Log.wtf(tag, tr);
    }

    
    public static void wtf(String tag, String msg, Throwable tr) {
        android.util.Log.wtf(tag, msg, tr);
    }

    public static String getStackTraceString(Throwable ex) {
         return android.util.Log.getStackTraceString(ex);
    }
}
