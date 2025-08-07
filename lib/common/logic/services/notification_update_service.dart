import 'package:netguard/netguard.dart';

class NotificationUpdateService {
  NotificationUpdateService(
    this.sessionCubit,
    this.vpnController, {
    this.intervalMs = 500,
  });

  final int intervalMs;

  final SessionCubit sessionCubit;
  final VpnController vpnController;

  SessionLogAnalysisState? lastState;
  bool active = false;

  void run() {
    active = true;
    _run();
  }

  void _run() {
    if (!active) return;
    if (lastState != sessionCubit.state.sessionAnalysis.state) {
      vpnController.updateStatsNotification(
        sessionCubit.state.sessionStatistics,
      );
      lastState = sessionCubit.state.sessionAnalysis.state;
    }
    Future.delayed(Duration(milliseconds: intervalMs), _run);
  }

  void stop() {
    active = false;
  }
}
