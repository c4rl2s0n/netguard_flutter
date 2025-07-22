import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:netguard/common/common.dart';

import 'worker.dart';

/// Worker that maintains a LoadingCubit and synchronizes its state with the isolate
class ProgressWorker extends Worker {
  final LoadingCubit _loadingCubit;
  late LoadingState _latestState = _loadingCubit.state;
  StreamSubscription? _stateUpdateListener;

  final Completer _done = Completer();

  ProgressWorker(this._loadingCubit, ProgressTask task)
    : super.fromTask(task){
    _init();
  }

  void _init(){
    _stateUpdateListener = _loadingCubit.stream.listen(_onStateUpdate);
  }
  
  Future awaitDone()async{
    if(_done.isCompleted) return;
    await _done.future;
  }
  
  void updateState(Function(LoadingCubit) update){
    update(_loadingCubit);
    _latestState = _loadingCubit.state;
    sendPort.send(_latestState);
  }

  @override
  bool handleMessage(dynamic message) {
    if (super.handleMessage(message)) {
      return true;
    }
    if (message is LoadingState) {
      if (message.hasError && message.error != _latestState.error) {
        FlutterError.onError?.call(FlutterErrorDetails(
          exception: message.error!,
          stack: message.error is Error ? (message.error as Error).stackTrace : null,
          library: "NetGuard - Isolated Progress-Task",
        ));
      }
      _latestState = message;
      _loadingCubit.pushState(message);
      if (_shouldDispose(message)) {
        _done.complete();
        dispose();
      }
    }
    return true;
  }

  bool _shouldDispose(LoadingState state) {
    return !_done.isCompleted && state.finished;
  }

  @override
  Future dispose() async {
    await _stateUpdateListener?.cancel();
    super.dispose();
  }

  Future<void> executeTask(dynamic argument, {bool wait=true}) async {
    if (!isReady) {
      await isolateReady;
    }
    //processNotifier.add(LoadingProgress.initial().startLoading());
    sendPort.send(argument);
    if(wait) await awaitDone();
  }

  // push state updates to the isolate, in case the state did not come from the isolate in the first place
  void _onStateUpdate(LoadingState state) {
    if(state != _latestState){
      updateState((lc) => lc.pushState(state));
    }
  }
}
