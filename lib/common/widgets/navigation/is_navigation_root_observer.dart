import 'package:flutter/material.dart';

/// RouteObserver that keeps track of the navigation level, allowing to check for root-route
class IsNavigationRootObserver extends RouteObserver<PageRoute<dynamic>>{
  IsNavigationRootObserver();

  int _level = 0;
  void _setLevel(int l) {
    _level = l;
    _logLevel();
  }
  void _incLevel() => _setLevel(_level+1);
  void _decLevel() => _setLevel(_level-1);

  bool get isRoot => _level <= 0;

  // TODO: figure out when and why this fails...
  void _logLevel() => print("NAVIGATION LEVEL: $_level");

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    _incLevel();
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    _decLevel();
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    _decLevel();
  }
}
