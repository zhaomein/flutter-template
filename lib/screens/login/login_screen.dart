import 'package:com.kaiyouit.caiwai/blocs/app/app_bloc.dart';
import 'package:com.kaiyouit.caiwai/config/routes.dart';
import 'package:com.kaiyouit.caiwai/extensions/color_extension.dart';
import 'package:com.kaiyouit.caiwai/language.dart';
import 'package:com.kaiyouit.caiwai/blocs/login/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

class LoginScreen extends StatelessWidget {
  void _signIn(context) async {}

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);

    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(AppBloc.of(context).authRepository),
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            Navigator.of(context)
                .pushNamedAndRemoveUntil(Routes.home, (r) => false);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(AppLg.of(context).trans('login')),
          ),
          body: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 50, left: 50, right: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(AppLg.of(context).trans('username_or_email'),
                      style: TextStyle(color: Colors.blue)),
                  TextFormField(
                    decoration: InputDecoration(),
                  ),
                  SizedBox(height: 15),
                  Text(AppLg.of(context).trans('password'),
                      style: TextStyle(color: Colors.blue)),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(

                    ),
                  ),
                  SizedBox(height: 80),
                  Center(
                    child: CupertinoButton(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        onPressed: () => _signIn(context),
                        child: Text(AppLg.of(context).trans('login'),
                            style: TextStyle(color: Colors.white),
                        ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
