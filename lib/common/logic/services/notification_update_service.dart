import 'package:netguard/netguard.dart';

class NotificationUpdateService {
  NotificationUpdateService(
    this.sessionStateStream,
    this.vpnController, {
    this.intervalMs = 500,
  }){
    sessionStateStream.listen(onSessionState);
  }

  final int intervalMs;

  final Stream<SessionState> sessionStateStream;
  final VpnController vpnController;

  SessionLogAnalysisState? lastState;
  SessionState? currentSessionState;
  bool active = false;

  void run() {
    active = true;
    _run();
  }

  void _run() {
    if (!active) return;
    if (lastState != currentSessionState?.sessionAnalysis.state) {
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

  void onSessionState(SessionState event) {
    currentSessionState = event;
  }
}
