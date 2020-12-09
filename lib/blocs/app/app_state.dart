import 'package:com.ourlife.app/data/models/user.dart';
import 'package:flutter/material.dart';

class AppState {
  final String language;
  final ThemeData theme;
  final String token;
  final User me;

  AppState({this.language, this.token, this.me, this.theme});

  bool get isAuthenticated => token != null && me != null;

  AppState copyWith({String language, String token, User me, ThemeData theme}) => AppState(
      me: me ?? this.me,
      token: token ?? this.token,
      theme: theme ?? this.theme,
      language: language ?? this.language
  );

  AppState authenticated({User me, String token}) => copyWith(
      me: me,
      token: token
  );

  AppState unauthenticated({User me, String token}) => copyWith(token: null, me: null);

  AppState switchLanguage(String language) => copyWith(
      language: language
  );

  AppState switchTheme(ThemeData theme) => copyWith(
      theme: theme
  );

  @override
  String toString() {
    return "AppState {isAuthenticated: $isAuthenticated}";
  }

}