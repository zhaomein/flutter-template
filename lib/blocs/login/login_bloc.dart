import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:com.ourlife.app/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository = AuthRepository.getInstance();

  LoginBloc() : super(InitialLoginState());

  static LoginBloc of(context) {
    return BlocProvider.of<LoginBloc>(context);
  }

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginStart) {
      yield LoginProcessState();

      var res = await authRepository.login(event);

      if(res is Map) {
        yield LoginSuccessState(
            user: res['user'],
            token: res['token']
        );
      } else {
        yield LoginFailState(res);
      }
    }
  }

}