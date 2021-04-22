import 'dart:convert';
import 'package:mcaio/data/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AuthRepository {
  static final AuthRepository _singleton = AuthRepository._internal();
  static AuthRepository getInstance() => _singleton;
  AuthRepository._internal();

  Future<dynamic> login() async {
    await Future.delayed(Duration(milliseconds: 500));

    // call api here
    var user = User(
      id: 'id',
      password: '12345',
      email: 'test@gmail.com'
    );
    var token = '<access token>';

    this.saveInfo(
      token: token,
      me: user,
    );
    return {
      'user': user,
      'token': token,
    };
  }

  Future<Map> getSavedInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final token = prefs.getString("user_token");
    if(token == null) {
      return null;
    }

    final me = prefs.getString("user_info");
    if(me == null) {
      return null;
    }

    return {
      'token': token,
      'me': User.fromMap(json.decode(me))
    };
  }

  void saveInfo({String token, User me}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("user_token", token);
    prefs.setString("user_info", json.encode(me.asMap));
  }

}