import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:com.kaiyouit.caiwai/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

  LoginBloc(this.authRepository);

  static LoginBloc of(context) {
    return BlocProvider.of<LoginBloc>(context);
  }

  @override
  LoginState get initialState => InitialLoginState();

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