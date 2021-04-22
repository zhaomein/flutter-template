
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../language.dart';
import 'base/model.dart';

class User extends Model {
  static String table = 'users';

  @override
  String get tableName => table;

  @override
  String get rowId => id;

  String id;
  String fullname;
  String email;
  String password;
  int point;

  User({this.id, this.fullname, this.email, this.password, this.point});

  static User fromMap(Map<String, dynamic> map)  {
    return User(
      id: map.containsKey('id') ? map['id'] : '',
      email: map.containsKey('email') ? map['email'] : '',
      password: map.containsKey('password') ? map['password'] : '',
      fullname: map.containsKey('fullname') ? map['fullname'] : '',
    );
  }

  @override
  Map<String, dynamic> get asMap => {
    'id': id,
    'fullname': fullname,
    'email': email,
    'password': password
  };
}