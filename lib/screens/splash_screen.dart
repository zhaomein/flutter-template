
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mcaio/app/app_bloc.dart';
import 'package:mcaio/config/routes.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AppBloc, AppState>(
        listener: (context, state) {
          if(state.isAuthenticated) {
            // when has token
            Navigator.of(context).pushNamedAndRemoveUntil(Routes.home, (r) => false);
          } else {
            Navigator.of(context).pushNamedAndRemoveUntil(Routes.login, (r) => false);
          }
        },
        child: Scaffold(
          body: Center(
            child: Icon(Icons.event, size: 60),
          ),
        )
    );
  }
}