import 'package:com.kaiyouit.caiwai/screens/login/login_screen.dart';
import 'package:com.kaiyouit.caiwai/screens/splash_screen.dart';
import 'package:com.kaiyouit.caiwai/screens/welcome_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:com.kaiyouit.caiwai/screens/main_screen.dart';

class Routes {
  static const String splash = '/';
  static const String welcome = '/welcome';
  static const String home = '/home';
  static const String login = '/login';

  static Map map = {
    splash: CupertinoPageRoute(builder:(context) => SplashScreen()),
    welcome: CupertinoPageRoute(builder:(context) => WelcomeScreen()),
    home: CupertinoPageRoute(builder:(context) => MainScreen()),
    login: CupertinoPageRoute(builder:(context) => LoginScreen()),
  };

  static Future<dynamic> pushTo(BuildContext context, Widget screen ) async {
    return Navigator.of(context).push(CupertinoPageRoute(builder:(context) => screen));
  }

}

