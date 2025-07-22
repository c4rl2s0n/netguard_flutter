import 'package:netguard/common/common.dart';

import 'isolated_task.dart';

abstract class ProgressTask extends IsolatedTask {
  ProgressTask();

  Future execute(
    LoadingCubit loadingCubit,
    dynamic taskArgument, {
    bool wait = true,
  }) async {
    ProgressWorker worker = ProgressWorker(loadingCubit, this);
    Future<void> execution = worker.executeTask(taskArgument);
    if (wait) await execution;
  }

  final LoadingCubit _loadingCubit = LoadingCubit();
  LoadingState get loadingState => _loadingCubit.state;

  void updateProgress(Function(LoadingCubit) update) {
    update(_loadingCubit);
    sendPort.send(loadingState);
  }

  @override
  void isolatedTaskErrorLayer(dynamic message) async {
    if (message is LoadingState) {
      _loadingCubit.pushState(message);
      return;
    }
    try {
      await isolatedTask(message);
    } on Exception catch (e) {
      updateProgress((lc) => lc.setError(e));
    } on Error catch (e) {
      updateProgress((lc) => lc.setError(e));
    }
  }
}
