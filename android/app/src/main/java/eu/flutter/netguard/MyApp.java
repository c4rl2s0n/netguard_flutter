package eu.flutter.netguard;

import android.app.Application;
import android.content.Context;

import eu.flutter.netguard.flutter.NativeBridge;
import eu.flutter.netguard.flutter.VpnApiImpl;
import eu.flutter.netguard.flutter.VpnEventChannel;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.FlutterEngineCache;
import io.flutter.embedding.engine.dart.DartExecutor;
import io.flutter.plugin.common.BinaryMessenger;

public class MyApp extends Application {
    public static final String ENGINE_ID = "shared_engine";

    @Override
    public void onCreate() {
        super.onCreate();

        // Create and start the engine
        FlutterEngine engine = new FlutterEngine(this);

        // Execute default entrypoint (can be 'main' or custom background entrypoint)
        engine.getDartExecutor().executeDartEntrypoint(
                DartExecutor.DartEntrypoint.createDefault()
        );

        // Set up platform channels once here
        BinaryMessenger binaryMessenger = engine.getDartExecutor().getBinaryMessenger();
        VpnEventChannel.setUp(binaryMessenger);
        NativeBridge.VpnController.setUp(binaryMessenger, new VpnApiImpl(this));

        // Cache engine for UI use
        FlutterEngineCache.getInstance().put(ENGINE_ID, engine);
    }
}
