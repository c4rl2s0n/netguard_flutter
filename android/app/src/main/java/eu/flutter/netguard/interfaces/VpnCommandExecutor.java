package eu.flutter.netguard.interfaces;

import eu.flutter.netguard.flutter.NativeBridge;

public interface VpnCommandExecutor {
    void startVpn();
    void reloadVpn();
    void stopVpn();
    void updateStatsNotification(NativeBridge.SessionStatistics sessionStatistics);
}
