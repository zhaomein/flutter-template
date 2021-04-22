import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mcaio/screens/login/login_screen.dart';
import 'package:mcaio/screens/main/main_screen.dart';
import 'package:mcaio/screens/splash_screen.dart';

class Routes {
  static const String home = '/home';
  static const String splash = '/splash';
  static const String login = '/login';

  static Map<String, Widget Function(BuildContext)> map = {
    splash: (context) => SplashScreen(),
    login: (context) => LoginScreen(),
    home: (context) => MainScreen(),
  };

  static Future<dynamic> pushTo(BuildContext context, Widget screen, {bool clear = false}) async {
    if(clear) {
      return Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(builder:(context) => screen), (r) => false);
    }
    return Navigator.of(context).push(CupertinoPageRoute(builder:(context) => screen));
  }
}

