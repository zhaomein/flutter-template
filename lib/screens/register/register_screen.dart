import 'package:com.ourlife.app/blocs/app/app_bloc.dart';
import 'package:com.ourlife.app/config/routes.dart';
import 'package:com.ourlife.app/extensions/color_extension.dart';
import 'package:com.ourlife.app/language.dart';
import 'package:com.ourlife.app/blocs/login/bloc.dart';
import 'package:com.ourlife.app/screens/register/widgets/register_step_one.dart';
import 'package:com.ourlife.app/screens/register/widgets/register_step_two.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:url_launcher/url_launcher.dart';

class RegisterScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);

    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(),
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            Navigator.of(context)
                .pushNamedAndRemoveUntil(Routes.home, (r) => false);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(AppLg.of(context).trans('register')),
          ),
          body: PageView(
//            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              RegisterStepOne(),
              RegisterStepTwo()
            ],
          ),
        ),
      ),
    );
  }
}
