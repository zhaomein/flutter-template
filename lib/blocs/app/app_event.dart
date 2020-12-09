import 'package:com.ourlife.app/data/models/user.dart';
import 'package:equatable/equatable.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AppEvent {}

class Authenticated extends AppEvent {
  final String token;
  final User user;

  Authenticated(this.token, this.user);

  @override
  List<Object> get props => [token, user];
}

class SwitchLanguage extends AppEvent {
  final String language;
  const SwitchLanguage(this.language);
  @override
  List<Object> get props => [language];
}

class LogOut extends AppEvent {}