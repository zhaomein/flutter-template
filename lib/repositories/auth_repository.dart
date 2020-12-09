import 'dart:convert';

import 'package:com.ourlife.app/blocs/login/login_event.dart';
import 'package:com.ourlife.app/blocs/register/register_event.dart';
import 'package:com.ourlife.app/data/models/user.dart';
import 'package:com.ourlife.app/config/api_constants.dart' as api;
import 'package:com.ourlife.app/providers/api_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:com.ourlife.app/extensions/string_extension.dart';


abstract class _AuthRepository {
  Future<Map> getSavedInfo();
  void saveInfo({String token, User me});
  Future<User> verifyToken(String token);
  Future<bool> forgotPassword();
  Future<dynamic> login(LoginStart data);
  Future<dynamic> register(RegisterProcess data);
  void logout();
}

class AuthRepository implements _AuthRepository {

  static final AuthRepository _singleton = AuthRepository._internal();
  static AuthRepository getInstance() => _singleton;
  AuthRepository._internal();

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

  Future<User> verifyToken(String token) async {
    throw UnimplementedError();
  }

  Future<dynamic> login(LoginStart data) async {
    var res = await ApiProvider().request(
        method: api.login['method'],
        url: api.login['url'],
        params: {
          "password": data.password,
          "phone_number": data.phone.trimLeftChars("0"),
          "area_code": data.callingCode,
        }
    );

    if(res['status']) {
      final data = res['data'];
      final me = User.fromMap(data['user']);
      //save token
      this.saveInfo(
          token: data['token'],
          me: me
      );
      return {
        'token': data['token'],
        'user': me
      };
    }

    return res['error'] ?? 'unknown_error';
  }

  Future<dynamic> register(data) async {
    var res = await ApiProvider().request(
        method: api.register['method'],
        url: api.register['url'],
        params: {
          "email": data.email,
          "phone_number": data.phone.trimLeftChars("0"),
          "first_name": data.firstName,
          "last_name": data.lastName,
          "password": data.password,
          "token": data.firebaseToken,
          "area_code": data.callingCode,
          "gender": data.gender,
          "country": data.country,
          "city": data.city
        }
    );

    if(res['status']) {
      final data = res['data'];
      final me = User.fromMap(data['user']);
      //save token
      this.saveInfo(
          token: data['token'],
          me: me
      );
      return {
        'token': data['token'],
        'user': me
      };
    }

    return res['error'] ?? 'unknown_error';
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  Future<bool> forgotPassword() {
    throw UnimplementedError();
  }

}