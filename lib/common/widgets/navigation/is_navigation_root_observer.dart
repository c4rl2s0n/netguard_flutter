
import 'package:flutter/material.dart';

/// RouteObserver that keeps track of the navigation level, allowing to check for root-route
class IsNavigationRootObserver extends RouteObserver<PageRoute<dynamic>> {
  IsNavigationRootObserver();

  static int _level = 0;

  static bool get isRoot => _level <= 1;
  
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    _level++;
  }
  
  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    _level--;
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    _level--;
  }
}