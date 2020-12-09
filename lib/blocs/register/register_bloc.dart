import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:com.ourlife.app/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './bloc.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  
  final AuthRepository authRepository = AuthRepository.getInstance();

  RegisterBloc() : super(InitialRegisterState());

  static RegisterBloc of(context) {
    return BlocProvider.of<RegisterBloc>(context);
  }

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
