import 'package:com.ourlife.app/blocs/app/app_bloc.dart';
import 'package:com.ourlife.app/blocs/app/app_state.dart';
import 'package:com.ourlife.app/config/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AppBloc, AppState>(
      listener: (context, state) {
        if(state.isAuthenticated) {
          Navigator.of(context).pushNamedAndRemoveUntil(Routes.home, (r) => false);
        } else {
          Navigator.of(context).pushNamedAndRemoveUntil(Routes.login, (r) => false);
        }
      },
      child: Scaffold(
        body: Center(
          child: Image.asset(
            'resources/images/app-logo.png',
            width: 200,
          ),
        ),
      )
    );
  }
}

