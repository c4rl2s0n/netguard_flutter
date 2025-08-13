package eu.flutter.netguard.activities;

import android.content.Context;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import eu.flutter.netguard.MyApp;
import eu.flutter.netguard.flutter.NativeBridge;
import eu.flutter.netguard.flutter.VpnApiImpl;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.FlutterEngineCache;


public class MainActivity extends FlutterActivity {

    @Nullable
    @Override
    public FlutterEngine provideFlutterEngine(@NonNull Context context) {
        return FlutterEngineCache.getInstance().get(MyApp.ENGINE_ID);
    }
}
