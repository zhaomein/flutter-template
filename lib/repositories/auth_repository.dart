import 'dart:convert';

import 'package:com.kaiyouit.caiwai/blocs/login/login_event.dart';
import 'package:com.kaiyouit.caiwai/data/models/user.dart';
import 'package:com.kaiyouit.caiwai/config/api_constants.dart' as api;
import 'package:com.kaiyouit.caiwai/data/providers/api_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:com.kaiyouit.caiwai/extensions/string_extension.dart';


class AuthRepository {

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

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  Future<bool> forgotPassword() {
    throw UnimplementedError();
  }

}