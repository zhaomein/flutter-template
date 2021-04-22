import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mcaio/app/app_bloc.dart';
import 'package:mcaio/data/models/user.dart';
import 'package:mcaio/repositories/auth_repository.dart';
import 'package:meta/meta.dart';
import 'package:provider/provider.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(InitialLoginState());
  AuthRepository _authRepository = AuthRepository.getInstance();

  static LoginBloc of(context) => Provider.of<LoginBloc>(context, listen: false);

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if(event is StartLoginEvent) {
      yield LoginProcessingState();
      yield* _startLogin(event);
      return;
    }
  }

  Stream<LoginState> _startLogin(StartLoginEvent event) async* {
    var res = await _authRepository.login();

    if(!(res is String)) {
      yield LoginSuccessState(
        token: res['token'],
        user: res['user'],
      );
    } else {
      yield LoginFailState('Login fail');
    }
  }
}
