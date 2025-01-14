import 'package:flutter/material.dart';

class GoRouterObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    debugPrint(
        'Pushing: ${route.settings.name}, type: ${route.runtimeType} with arguments: ${route.settings.arguments}');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    debugPrint(
        'Poping: ${route.settings.name}, type: ${route.runtimeType} with arguments: ${route.settings.arguments}');
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    debugPrint(
        'Removing: ${route.settings.name}, type: ${route.runtimeType} with arguments: ${route.settings.arguments}');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    debugPrint(
        'Replacing: ${newRoute?.settings.name}, type: ${newRoute.runtimeType} with arguments: ${newRoute?.settings.arguments}');
  }
}
