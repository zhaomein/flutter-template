import 'package:com.kaiyouit.caiwai/screens/login/login_screen.dart';
import 'package:com.kaiyouit.caiwai/screens/register/register_screen.dart';
import 'package:com.kaiyouit.caiwai/screens/splash_screen.dart';
import 'package:com.kaiyouit.caiwai/screens/welcome_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:com.kaiyouit.caiwai/screens/main_screen.dart';

class Routes {
  static const String splash = '/';
  static const String welcome = '/welcome';
  static const String home = '/home';
  static const String login = '/login';
  static const String register = '/register';

  static Route<dynamic> appRoutes(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return CupertinoPageRoute(builder:(context) => SplashScreen());
      case welcome:
        return CupertinoPageRoute(builder:(context) => WelcomeScreen());
      case home:
        return CupertinoPageRoute(builder:(context) => MainScreen());
      case login:
        return CupertinoPageRoute(builder:(context) => LoginScreen());
      case register:
        return CupertinoPageRoute(builder:(context) => RegisterScreen());
    }

    return CupertinoPageRoute(builder:(context) => SplashScreen());
  }

  static Future<dynamic> pushTo(BuildContext context, Widget screen ) async {
    return Navigator.of(context).push(CupertinoPageRoute(builder:(context) => screen));
  }
}

