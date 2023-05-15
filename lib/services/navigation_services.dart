import 'package:flutter/material.dart';

class NavigationService {
  late GlobalKey<NavigatorState> navigationKey;

  static NavigationService instance = NavigationService();

  NavigationService() {
    navigationKey = GlobalKey<NavigatorState>();
  }

  Future<dynamic> navigateToReplacement(String rn) {
    return navigationKey.currentState!
        .pushNamedAndRemoveUntil(rn, (route) => false);
  }

  Future<dynamic> navigateTo(String rn) {
    return navigationKey.currentState!.pushNamed(rn);
  }

  goback() {
    return navigationKey.currentState!.pop();
  }
}
