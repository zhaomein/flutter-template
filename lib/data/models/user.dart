
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
  String firstName;
  String lastName;
  String callingCode;
  String gender;
  String phone;
  String email;
  String avatar;
  String coverImage;
  String description;
  String country;
  String city;
  String birthday;
  DateTime lastActive;
  bool isOnline;
  String get fullName => "$firstName $lastName";

  User({
    this.id, this.firstName, this.lastName, this.callingCode, this.birthday,
    this.phone, this.avatar, this.isOnline = false, this.email, this.gender = 'male',
    this.coverImage, this.description, this.city, this.country = 'VN',
    this.lastActive
  });


  static User fromMap(Map map) => User(
    id: map['_id'] ?? '',
    avatar: map['avatar'] ?? '',
    email: map['email'] ?? '',
    coverImage: map['cover_url'] ?? '',
    firstName: map['first_name'] ?? '',
    lastName: map['last_name'] ?? '',
    gender: map['gender'] ?? 'male',
    callingCode: map['area_code'] ?? '',
    phone: map['phone_number'] ?? '',
    birthday: map['birthday'] ?? '',
    description: map['description'] ?? '',
    country: map['country'],
    city: map['city'],
    isOnline: map['online'] ?? false,
    lastActive: map['last_active'] != null ? DateTime.parse(map['last_active']).toLocal() : DateTime.now()
  );

  @override
  Map<String, dynamic> get asMap => {
    '_id': id,
    'avatar': avatar,
    'email': email,
    'gender': gender,
    'cover_image': coverImage,
    'first_name': firstName,
    'last_name': lastName,
    'area_code': callingCode,
    'phone_number': phone,
    'description': description,
    'country': country,
    'city': city,
    'birthday': birthday,
    'online': isOnline,
    'last_active': DateFormat("yyyy-MM-dd HH:mm:ss").format(lastActive)
  };


  String getGender(context) => AppLg.of(context).trans(gender);

  ImageProvider getAvatar() {
    return avatar != null && avatar.isNotEmpty ? NetworkImage(avatar) :
        AssetImage("resources/images/default_avatar_$gender.png");
  }

  DateTime getBirthday() {
    final birthdayStr = birthday.split('/');
    try {
      return DateTime(
          int.parse(birthdayStr.last),
          int.parse(birthdayStr[1]),
          int.parse(birthdayStr[0])
      );
    } catch(Exception) {
      return DateTime(1970);
    }
  }

  String getActiveStatus(context) {
    if(isOnline) {
      return AppLg.of(context).trans('active_now');
    }
    
    final diff = lastActive.difference(DateTime.now());
    if(diff.inDays > 0 ) {
      return  DateFormat("HH:mm").format(lastActive);
    } 

    return  DateFormat("dd/MM/yyyy").format(lastActive);
  }

}