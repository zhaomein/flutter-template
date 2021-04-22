part of 'app_bloc.dart';


class AppState {
  static String accessToken;

  final String language;
  final String token;
  final User me;

  AppState({this.language, this.token, this.me});

  bool get isAuthenticated => me != null;

  AppState copyWith({String language, String token, User me}) => AppState(
      me: me ?? this.me,
      token: token ?? this.token,
      language: language ?? this.language,
  );

  AppState authenticated({User me, String token}) => copyWith(
      me: me,
      token: token
  );

  AppState unauthenticated({User me, String token}) => copyWith(token: null, me: null);

  AppState switchLanguage(String language) => copyWith(
      language: language
  );

}