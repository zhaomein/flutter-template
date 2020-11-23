import 'package:com.kaiyouit.caiwai/config/routes.dart';
import 'package:com.kaiyouit.caiwai/extensions/color_extension.dart';
import 'package:com.kaiyouit.caiwai/language.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              color: HexColor.fromHex("#95e0f9"),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      "assets/images/app-logo.png",
                      height: 100,
                    ),
                    Text("Caiwai", style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700
                    ))
                  ],
                ),
              ),
            ),
          ),
          CupertinoButton(
            onPressed: () => Navigator.of(context).pushNamed(Routes.login),
            color: HexColor.fromHex('#FAE232'),
            borderRadius: BorderRadius.zero,
            padding: EdgeInsets.only(top: 40, bottom: 40),
            child: Container(
              alignment: Alignment.center,
              child: Text(AppLg.of(context).trans('login'), style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 30
              )),
            ),
          ),
          CupertinoButton(
            onPressed: () => Navigator.of(context).pushNamed(Routes.login),
            color: HexColor.fromHex('#FF968D'),
            borderRadius: BorderRadius.zero,
            padding: EdgeInsets.only(top: 40, bottom: 40),
            child: Container(
              alignment: Alignment.center,
              child: Text(AppLg.of(context).trans('register'), style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 30
              )),
            ),
          ),
        ],
      ),
    );
  }

}