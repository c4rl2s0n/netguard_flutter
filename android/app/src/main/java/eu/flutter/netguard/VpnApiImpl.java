package eu.flutter.netguard;


import android.content.Intent;
import android.net.VpnService;

import androidx.annotation.NonNull;
import androidx.core.content.ContextCompat;

import eu.flutter.netguard.utils.Util;
import eu.flutter.netguard.utils.Values;

public class VpnApiImpl implements NativeBridge.VpnController {
    private final MainActivity context;

    public VpnApiImpl(MainActivity context) {
        this.context = context;
    }
    @Override
    public void startVpn(@NonNull NativeBridge.VpnSettings settings) {
        Intent prepareIntent = VpnService.prepare(context);
        if (prepareIntent != null) {
            // Need user consent — ask MainActivity to launch permission
            context.requestVpnPermission(prepareIntent, settings);
        } else {
            // Permission already granted — start VPN directly
            context.startVpnServiceWithSettings(settings);
        }
    }

    @Override
    public void stopVpn() {
        Intent intent = new Intent(context, MyVpnService.class);
        intent.setAction(Values.Intent.Actions.STOP);
        context.startService(intent);
    }

    @NonNull
    @Override
    public Boolean isRunning() {
        return false;
        //return MyVpnService.isRunning();
    }

    @Override
    public void updateSettings(@NonNull NativeBridge.VpnSettings settings) {
        Intent intent = new Intent(context, MyVpnService.class);
        intent.setAction(Values.Intent.Actions.UPDATE_SETTINGS);
        intent.putExtra("settings", Util.serializeSettings(settings));
        ContextCompat.startForegroundService(context, intent);
    }
}