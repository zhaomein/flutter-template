import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(Cubit cubit) {
    super.onCreate(cubit);
    print('Bloc Create -- ${cubit.runtimeType}');
  }

  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print('Bloc Event -- ${bloc.runtimeType}, event: $event');
  }

  @override
  void onChange(Cubit cubit, Change change) {
    super.onChange(cubit, change);
    print('Bloc Change -- ${cubit.runtimeType}, change: $change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print('Bloc Transition -- ${bloc.runtimeType}, transition: $transition');
  }

  @override
  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
    print('Bloc Error -- ${cubit.runtimeType}, error: $error');
    super.onError(cubit, error, stackTrace);
  }

  @override
  void onClose(Cubit cubit) {
    super.onClose(cubit);
    print('Bloc Close -- ${cubit.runtimeType}');
  }
}