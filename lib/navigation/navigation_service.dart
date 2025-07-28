import 'package:flutter/material.dart';
import 'package:insta_canvas/homeModule/screens/home_screen.dart';
import '../authModule/screens/splash_screen.dart';
import '../bottom_nav_bar.dart';
import 'arguments.dart';
import 'routes.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case NamedRoute.homeScreen:
      return _getPageRoute(const HomeScreen());
    case NamedRoute.bottomNavigation:
      return _getPageRoute(
          BottomNavBar(args: settings.arguments as BottomNavArgumnets));
    //Common
    default:
      return _getPageRoute(const SplashScreen());
  }
}

PageRoute _getPageRoute(Widget screen) {
  return MaterialPageRoute(builder: (context) => screen);
}
