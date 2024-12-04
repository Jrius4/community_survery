import 'package:community_survery/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:community_survery/screens/survery_screen.dart';

class InAppRoutes {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return _materialRoute(const HomeScreen(), settings);
      case "/survey":
        return _materialRoute(const SurveyScreen(), settings);
      default:
        return _materialRoute(
            Scaffold(
              appBar: AppBar(
                title: const Text('Error'),
                backgroundColor: Colors.white,
                elevation: 0,
              ),
              body: const Center(
                child: Text("No route defined for this path"),
              ),
            ),
            settings);
    }
  }

  static Route _materialRoute(Widget screen, RouteSettings settings) {
    return MaterialPageRoute(settings: settings, builder: (context) => screen);
  }
}
