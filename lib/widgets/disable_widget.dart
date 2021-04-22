import './loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DisableWidget extends StatelessWidget {
  final bool disable;
  final Widget child;
  final Color disabledColor;
  final bool showLoading;

  const DisableWidget({
    this.disable,
    this.child,
    this.disabledColor,
    this.showLoading = false
  });

  @override
  Widget build(BuildContext context) {
      return WillPopScope(
        child: Stack(
          children: <Widget>[
            child,
            (disable ?? false) ? Positioned(
              top: 0,
              right: 0,
              bottom: 0,
              left: 0,
              child: !showLoading ? Container() : Center(
                child: SizedBox(
                  height: 25,
                  width: 25,
                  child: CircularProgressIndicator(),
                ),
              ),
            ) : SizedBox()
          ]
        ),
        onWillPop: () async => !disable,
      );
    }
}