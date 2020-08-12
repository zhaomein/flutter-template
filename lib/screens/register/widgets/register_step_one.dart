import 'package:com.kaiyouit.caiwai/config/constants.dart';
import 'package:com.kaiyouit.caiwai/language.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RegisterStepOne extends StatelessWidget {
  void _nextStep(context) async {}

  void _openUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 50, left: 50, right: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(AppLg.of(context).trans('name_eg'),
                style: TextStyle(color: Colors.blue)),
            TextFormField(
              decoration: InputDecoration(),
            ),
            SizedBox(height: 15),
            Text(AppLg.of(context).trans('last_name_eg'),
                style: TextStyle(color: Colors.blue)),
            TextFormField(
              decoration: InputDecoration(),
            ),
            SizedBox(height: 30),
            RichText(
              text: TextSpan(
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      height: 2,
                      fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(text: AppLg.of(context).trans('i_agree_with')),
                    TextSpan(
                        text: AppLg.of(context).trans('privacy_policy'),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            _openUrl(PRIVACY_POLICY);
                          }),
                    TextSpan(text: AppLg.of(context).trans('and')),
                    TextSpan(
                        text: AppLg.of(context).trans('terms_of_use'),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            _openUrl(TERMS_OF_USE);
                          }),
                    TextSpan(
                        text: AppLg.of(context).trans('ja_after_terms_of_use')),
                  ]),
            ),
            SizedBox(height: 80),
            Center(
              child: CupertinoButton(
                color: Colors.blue,
                borderRadius: BorderRadius.all(Radius.circular(15)),
                onPressed: () => _nextStep(context),
                child: Text(
                  AppLg.of(context).trans('accept_and_continue'),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
