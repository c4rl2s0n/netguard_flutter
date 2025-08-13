package eu.flutter.netguard.activities;

import android.app.Activity;
import android.content.Intent;
import android.net.VpnService;
import android.os.Bundle;

import androidx.core.content.ContextCompat;

import eu.flutter.netguard.MyVpnService;
import eu.flutter.netguard.utils.Values;

/// Activity responsible for starting the VpnService and checking for permissions
public class VpnStartupActivity extends Activity {
    private static final int VPN_REQUEST_CODE = 1000;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        Intent prepareIntent = VpnService.prepare(this);
        if (prepareIntent != null) {
            startActivityForResult(prepareIntent, VPN_REQUEST_CODE);
        } else {
            onActivityResult(VPN_REQUEST_CODE, RESULT_OK, null);
        }
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        if (requestCode == VPN_REQUEST_CODE && resultCode == RESULT_OK) {
            startVpnService();
        }
        finish(); // Close immediately
    }

    private void startVpnService() {
        Intent intent = new Intent(this, MyVpnService.class);
        intent.setAction(Values.Intent.Actions.START);
        ContextCompat.startForegroundService(this, intent);
    }
}

