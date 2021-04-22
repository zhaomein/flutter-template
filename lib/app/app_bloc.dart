import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mcaio/data/models/user.dart';
import 'package:mcaio/repositories/auth_repository.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {

  static AppBloc of(context) => BlocProvider.of<AppBloc>(context, listen: false);
  final AuthRepository authRepository = AuthRepository.getInstance();

  AppBloc() : super(AppState(language: 'ja')) {
    this.add(AppStarted());
  }

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is AppStarted) {
      yield* _appStarted();
      return;
    }

    if (event is LogOut) {
      yield state.unauthenticated();
      return;
    }

    if(event is Authenticated) {
      yield state.authenticated(
          token: event.token,
          me: event.user
      );
      return;
    }

    if(event is SwitchLanguage) {
      yield state.switchLanguage(event.language);
    }
  }

  Stream<AppState> _appStarted() async* {
    await Future.delayed(Duration(seconds: 1));
    final info = await authRepository.getSavedInfo();

    if (info != null) {
      yield state.authenticated(
          token: info['token'],
          me: info['me']
      );
    } else {
      yield state.unauthenticated();
    }
  }
}