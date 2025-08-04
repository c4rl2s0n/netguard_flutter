package eu.flutter.netguard;


import android.content.Intent;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.net.VpnService;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Objects;

import eu.flutter.netguard.data.ModelBuilder;
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
        MyVpnService.updateVpnConfig(context, config);
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

    @Nullable
    @Override
    public VpnConfig getSession() {
        return MyVpnService.getSessionConfig();
    }

    @Override
    public void updateSettings(@NonNull VpnConfig config) {
        MyVpnService.updateVpnConfig(context, config);
    }

    @NonNull
    @Override
    public List<Application> getApplications() {
        PackageManager pm = context.getPackageManager();
        List<ApplicationInfo> applicationInfos = pm.getInstalledApplications(ApplicationInfo.FLAG_INSTALLED);
        List<Application> applications = new ArrayList<>();
        String self = context.getPackageName();
        for (ApplicationInfo app : applicationInfos) {
            if(Objects.equals(app.packageName, self)) continue;
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
                comparison = application.getLabel().toLowerCase().compareTo(t1.getLabel().toLowerCase());
            }
            if (comparison == 0) {
                comparison = application.getPackageName().compareTo(t1.getPackageName());
            }
            return comparison;
        });
        return applications;
    }
}