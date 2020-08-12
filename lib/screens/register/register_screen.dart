import 'package:com.kaiyouit.caiwai/blocs/app/app_bloc.dart';
import 'package:com.kaiyouit.caiwai/config/constants.dart';
import 'package:com.kaiyouit.caiwai/config/routes.dart';
import 'package:com.kaiyouit.caiwai/extensions/color_extension.dart';
import 'package:com.kaiyouit.caiwai/language.dart';
import 'package:com.kaiyouit.caiwai/blocs/login/bloc.dart';
import 'package:com.kaiyouit.caiwai/screens/register/widgets/register_step_one.dart';
import 'package:com.kaiyouit.caiwai/screens/register/widgets/register_step_two.dart';
import 'package:com.kaiyouit.caiwai/widgets/rounded_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
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
      create: (context) => LoginBloc(AppBloc.of(context).authRepository),
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            Navigator.of(context)
                .pushNamedAndRemoveUntil(Routes.home, (r) => false);
          }
        },
        child: RoundedScaffold(
          appbarColors: [
            HexColor.fromHex('#FF968D'),
            HexColor.fromHex('#FF968D')
          ],
          appBar: AppBar(
            title: Text(AppLg.of(context).trans('register')),
          ),
          child: PageView(
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
