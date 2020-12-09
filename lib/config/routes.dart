import 'package:com.ourlife.app/screens/login/login_screen.dart';
import 'package:com.ourlife.app/screens/register/register_screen.dart';
import 'package:com.ourlife.app/screens/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:com.ourlife.app/screens/main_screen.dart';

class Routes {
  static const String splash = '/';
  static const String welcome = '/welcome';
  static const String home = '/home';
  static const String login = '/login';
  static const String register = '/register';


  static Map<String, Widget Function(BuildContext)> map = {
    splash: (context) => SplashScreen(),
    home: (context) => MainScreen(),
    login: (context) => LoginScreen(),
    register: (context) => RegisterScreen()
  };

  static Future<dynamic> pushTo(BuildContext context, Widget screen, {bool clear = false}) async {
    if(clear) {
      return Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(builder:(context) => screen), (r) => false);
    }
    return Navigator.of(context).push(CupertinoPageRoute(builder:(context) => screen));
  }


}

