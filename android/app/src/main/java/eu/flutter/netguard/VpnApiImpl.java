package eu.flutter.netguard;


import android.content.Intent;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.net.VpnService;

import androidx.annotation.NonNull;
import androidx.core.content.ContextCompat;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import eu.flutter.netguard.utils.ModelBuilder;
import eu.flutter.netguard.utils.Util;
import eu.flutter.netguard.utils.Values;
import eu.flutter.netguard.NativeBridge.*;

public class VpnApiImpl implements VpnController {
    private final MainActivity context;

    public VpnApiImpl(MainActivity context) {
        this.context = context;
    }
    @Override
    public void startVpn(@NonNull VpnConfig config) {
        MyVpnService.updateVpnConfig(config);
        Intent prepareIntent = VpnService.prepare(context);
        if (prepareIntent != null) {
            // Need user consent — ask MainActivity to launch permission
            context.requestVpnPermission(prepareIntent);
        } else {
            // Permission already granted — start VPN directly
            context.startVpnService();
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
        return MyVpnService.isRunning();
    }

    @Override
    public void updateSettings(@NonNull VpnConfig config) {
        MyVpnService.updateVpnConfig(config);
    }

    @NonNull
    @Override
    public List<Application> getApplications() {
        PackageManager pm = context.getPackageManager();
        List<ApplicationInfo> applicationInfos = pm.getInstalledApplications(ApplicationInfo.FLAG_INSTALLED);
        List<Application> applications = new ArrayList<>();
        for (ApplicationInfo app : applicationInfos) {
            PackageInfo info;
            String version = "";
            try {
                info = pm.getPackageInfo(app.packageName, PackageInfo.INSTALL_LOCATION_AUTO);
                if(info.versionName != null) {
                    version = info.versionName;
                }
            }catch (PackageManager.NameNotFoundException ignored){}
            byte[] icon = Util.drawableToByteArray(app.loadIcon(pm));
            applications.add(ModelBuilder.Application(
                    app.uid,
                    app.packageName,
                    app.loadLabel(pm).toString(),
                    version,
                    icon,
                    (app.flags & ApplicationInfo.FLAG_SYSTEM) != 0)
            );
        }
        Collections.sort(applications, (application, t1) -> {
            int comparison = application.getSystem().compareTo(t1.getSystem());
            if (comparison == 0) {
                comparison = application.getPackageName().compareTo(t1.getPackageName());
            }
            return comparison;
        });
        return applications;
    }
}