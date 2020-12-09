import 'package:com.ourlife.app/config/themes.dart';
import 'package:com.ourlife.app/repositories/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc.dart';

class AppBloc extends Bloc<AppEvent, AppState> {

  static AppBloc of(context) => BlocProvider.of<AppBloc>(context);

  final AuthRepository authRepository = AuthRepository.getInstance();

  AppBloc() : super(AppState(language: 'ja', theme: lightTheme)) {
    assert(authRepository != null);
    this.add(AppStarted());
  }

  @override
  Stream<AppState> mapEventToState(
      AppEvent event,
      ) async* {
    if (event is AppStarted) {
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

    } else if (event is LogOut) {
      authRepository.logout();
      yield state.unauthenticated();

    } else if(event is Authenticated) {
      yield state.authenticated(
          token: event.token,
          me: event.user
      );

    } else if(event is SwitchLanguage) {
      yield state.switchLanguage(event.language);
    }
  }
}
