import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mcaio/app/app_bloc.dart';
import 'package:mcaio/config/routes.dart';
import 'package:mcaio/language.dart';
import 'package:mcaio/screens/login/bloc/login_bloc.dart';
import 'package:mcaio/screens/main/main_screen.dart';
import 'package:mcaio/widgets/loading.dart';

class LoginScreen extends StatelessWidget {

  final LoginBloc _loginBloc = LoginBloc();

  void _signIn(context) {
    _loginBloc.add(StartLoginEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) =>  _loginBloc,
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if(state is LoginProcessingState) {
            Loading.of(context).show();
            return;
          }

          if(state is LoginSuccessState) {
            Loading.of(context).hide();
            AppBloc.of(context).add(Authenticated(
              state.token,
              state.user,
            ));

            Routes.pushTo(context, MainScreen());
            return;
          }
        },
        builder: (context, state) {
          return _buildUI(context, state);
        }
      ),
    );
  }

  Widget _buildUI(context, state) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  child: Image.asset("assets/images/checked.png"),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                  color: Colors.white,
                ),
                padding: EdgeInsets.only(top: 40, bottom: 20),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Text(
                        "Template",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 28,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Slogan",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 50, bottom: 120),
                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                          child: Column(
                            children: <Widget> [
                              SizedBox(
                                height: 60,
                                width: double.infinity,
                                child: RaisedButton(
                                  elevation: 10,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "assets/images/facebook.png",
                                        height: 35,
                                      ),

                                      SizedBox(width: 10,),

                                      Text(
                                        AppLg.of(context).trans("login_with_facebook"),
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      )
                                    ],
                                  ),
                                  color: Colors.blue,
                                  onPressed: () => _signIn(context),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                              ),

                              SizedBox(
                                height: 20,
                              ),

                              Text(
                                "------"+AppLg.of(context).trans("or")+ "------",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w300
                                ),
                              ),

                              SizedBox(
                                height: 20,
                              ),

                              SizedBox(
                                height: 60,
                                width: double.infinity,
                                child: RaisedButton(
                                  elevation: 10,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "assets/images/search.png",
                                        height: 35,
                                      ),

                                      SizedBox(width: 10,),

                                      Text(
                                        AppLg.of(context).trans("login_with_google"),
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ],
                                  ),
                                  color: Colors.orange,
                                  onPressed: () => _signIn(context),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                              ),
                            ],
                          )
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
      ),
    );
  }
}