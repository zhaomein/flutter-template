import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:com.kaiyouit.caiwai/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './bloc.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {

  final AuthRepository authRepository;

  RegisterBloc({this.authRepository});

  static RegisterBloc of(context) {
    return BlocProvider.of<RegisterBloc>(context);
  }

  @override
  RegisterState get initialState => InitialRegisterState();

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if(event is RegisterProcess) {

      yield RegisterProcessState();
      var res = await authRepository.register(event);

      if(res is Map) {
        yield RegisterSuccessState(
            token: res['token'],
            user: res['user']
        );
      } else {
        yield RegisterFailureState(res);
      }

    }
  }
}
