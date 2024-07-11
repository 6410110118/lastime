import 'package:flutter/material.dart';
import 'package:todo/screens/tab_screen.dart';

import '../screens/recycle_bin.dart';


class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RecycleBin.id:
        return MaterialPageRoute(builder: (context) {
          return const RecycleBin();
        });
      case TabsScreen.id:
        return MaterialPageRoute(builder: (context) {
          return const TabsScreen();
        });
      default:
        return null;
    }
  }
}
