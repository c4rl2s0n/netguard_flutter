package eu.flutter.netguard;

import android.content.Intent;

import androidx.core.content.ContextCompat;

import eu.flutter.netguard.utils.Values;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import eu.flutter.netguard.utils.Util;
import eu.flutter.netguard.NativeBridge.*;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.EventChannel;

public class MainActivity extends FlutterActivity {
    private static final int VPN_REQUEST_CODE = 1000;

    private VpnSettings vpnSettings;


    @Override
    public void configureFlutterEngine(FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);

        BinaryMessenger binaryMessenger = flutterEngine.getDartExecutor().getBinaryMessenger();

        VpnEventChannel.setUp(binaryMessenger);
        VpnController.setUp(binaryMessenger, new VpnApiImpl(this));

        //VpnApi.VpnController.setUp(binaryMessenger, new VpnApiImpl(this));
    }

    public void requestVpnPermission(Intent prepareIntent, VpnSettings settings) {
        this.vpnSettings = settings;
        startActivityForResult(prepareIntent, VPN_REQUEST_CODE);
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        if (requestCode == VPN_REQUEST_CODE) {
            if (resultCode == RESULT_OK) {
                // User granted permission, start the VPN service
                startVpnServiceWithSettings(vpnSettings);
            } else {
                // User denied permission — handle gracefully, maybe notify Flutter
            }
        } else {
            super.onActivityResult(requestCode, resultCode, data);
        }
    }

    public void startVpnServiceWithSettings(VpnSettings settings) {
        Intent intent = new Intent(this, MyVpnService.class);
        // Pass settings as extras in the intent (serialize as needed)
        intent.setAction(Values.Intent.Actions.START);
        intent.putExtra("settings", Util.serializeSettings(settings));
        ContextCompat.startForegroundService(this, intent);
    }
}
