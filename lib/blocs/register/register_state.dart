import 'package:com.kaiyouit.caiwai/data/models/user.dart';
import 'package:equatable/equatable.dart';

abstract class RegisterState extends Equatable {
  @override
  List<Object> get props => [];
  const RegisterState();
}

class InitialRegisterState extends RegisterState {}

class RegisterProcessState extends RegisterState {}

class RegisterSuccessState extends RegisterState {
  final String token;
  final User user;

  const RegisterSuccessState({this.token, this.user});
  @override
  List<Object> get props => [token, user];
}

class RegisterFailureState extends RegisterState {
  final String message;

  const RegisterFailureState(this.message);

  @override
  List<Object> get props => [message];
}