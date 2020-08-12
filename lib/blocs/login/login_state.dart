import 'package:com.kaiyouit.caiwai/data/models/user.dart';
import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object> get props => [];
  const LoginState();
}

class InitialLoginState extends LoginState {}

class LoginFailState extends LoginState {
  final String message;

  LoginFailState(this.message);

  @override
  List<Object> get props => [message];
}

class LoginProcessState extends LoginState {}

class LoginSuccessState extends LoginState {
  final User user;
  final String token;

  LoginSuccessState({this.user, this.token});
}