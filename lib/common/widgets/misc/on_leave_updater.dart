import 'package:flutter/material.dart';
import 'package:netguard/common/common.dart';

class OnLeaveUpdater extends StatefulWidget {
  const OnLeaveUpdater({required this.update, this.child, super.key});

  final void Function(BuildContext) update;
  final Widget? child;

  @override
  State<OnLeaveUpdater> createState() => _OnLeaveUpdaterState();
}

class _OnLeaveUpdaterState extends State<OnLeaveUpdater> with RouteAware {
  late final RouteObserver _routeObserver;
  late final bool initialized;

  @override
  @override
  void initState() {
    super.initState();
    try {
      _routeObserver = routeObserver;
      initialized = true;
    } catch (e) {
      LoggingService.onError(
        FlutterErrorDetails(
          exception: e,
          library: "Navigation - OnLeaveUpdater - RouteAware",
        ),
      );
      initialized = false;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!initialized) return;
    _routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    if (initialized) {
      _routeObserver.unsubscribe(this);
    }
    super.dispose();
  }

  /// the next view on the stack was pushed, leaving this view
  @override
  void didPushNext() {
    super.didPush();
    if (!initialized) return;
    widget.update(context);
  }

  /// this view is popped (leaving)
  @override
  void didPop() {
    super.didPopNext();
    if (!initialized) return;
    widget.update(context);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child ?? const SizedBox.shrink();
  }
}
