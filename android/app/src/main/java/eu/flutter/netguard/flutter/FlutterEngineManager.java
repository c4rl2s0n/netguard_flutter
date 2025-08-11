package eu.flutter.netguard.flutter;

import android.content.Context;
import android.content.SharedPreferences;

import androidx.preference.PreferenceManager;

import eu.flutter.netguard.MainActivity;
import eu.flutter.netguard.data.PersistenceCache;
import io.flutter.FlutterInjector;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.dart.DartExecutor;
import io.flutter.plugin.common.BinaryMessenger;

public class FlutterEngineManager {
    private static FlutterEngineManager instance;

    public static synchronized FlutterEngineManager getInstance(Context context) {
        if (instance == null) {
            instance = new FlutterEngineManager(context);
        }
        return instance;
    }
    private final Context context;
    private final MainActivity mainActivity;
    private final SharedPreferences mPrefs;
    private FlutterEngine uiFlutterEngine;
    private FlutterEngine headlessFlutterEngine;
    private boolean uiEngineAttached = false;
    private volatile boolean isBuffering = false;

    public boolean getIsBuffering(){
        return isBuffering;
    }

    private FlutterEngineManager(Context context){
        if(context instanceof MainActivity){
            mainActivity = (MainActivity) context;
        } else {
            mainActivity = null;
        }
        this.context = context.getApplicationContext();
        mPrefs = PreferenceManager.getDefaultSharedPreferences(this.context);
    }

    // Called when UI engine is created and attached
    public void onUiEngineAttached(FlutterEngine flutterEngine) {
        isBuffering = true;
        this.uiFlutterEngine = flutterEngine;
        this.uiEngineAttached = true;

        PersistenceCache.SetFlutterEngineAttached(mPrefs, uiEngineAttached);
        uiFlutterEngine.addEngineLifecycleListener(new FlutterEngine.EngineLifecycleListener() {
            @Override
            public void onPreEngineRestart() {

            }

            @Override
            public void onEngineWillDestroy() {
                onUiEngineDetached();
            }
        });

        // If headless engine is running, shut it down (handover control)
        if (headlessFlutterEngine != null) {
            VpnEventChannel.closeFlutterEngine();
            headlessFlutterEngine.destroy();
            headlessFlutterEngine = null;
        }
        SetupPlatformChannels(uiFlutterEngine);
        isBuffering = false;
    }

    // Called when UI engine is about to be destroyed
    public void onUiEngineDetached() {
        isBuffering = true;
        uiEngineAttached = false;
        uiFlutterEngine = null;
        PersistenceCache.SetFlutterEngineAttached(mPrefs, uiEngineAttached);
        VpnEventChannel.closeFlutterEngine();

        // start the engine
        startHeadlessFlutterEngine();
    }

    private void startHeadlessFlutterEngine() {
        if (headlessFlutterEngine != null) {
            // already running
            return;
        }

        headlessFlutterEngine = new FlutterEngine(context.getApplicationContext());

        // IMPORTANT: run your Dart entrypoint in the headless engine
        DartExecutor.DartEntrypoint entrypoint = new DartExecutor.DartEntrypoint(
                FlutterInjector.instance().flutterLoader().findAppBundlePath(),
                "headlessEntryPoint"  // This should be a Dart function annotated with @pragma('vm:entry-point')
        );
        headlessFlutterEngine.getDartExecutor().executeDartEntrypoint(entrypoint);

        // Initialize Pigeon APIs here on headlessFlutterEngine.getDartExecutor()
        SetupPlatformChannels(headlessFlutterEngine);

        // Now headless engine can receive messages from native VPN service and log traffic
        isBuffering = false;
    }

    private void SetupPlatformChannels(FlutterEngine flutterEngine){
        BinaryMessenger binaryMessenger = flutterEngine.getDartExecutor().getBinaryMessenger();
        VpnEventChannel.setUp(binaryMessenger);
        Context context = this.context;
        if(mainActivity != null) context = mainActivity;
        NativeBridge.VpnController.setUp(binaryMessenger, new VpnApiImpl(context));
    }

}


