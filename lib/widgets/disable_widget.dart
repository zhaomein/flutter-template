import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DisableWidget extends StatelessWidget {
  final bool disable;
  final Widget child;
  final Color disabledColor;

  const DisableWidget({this.disable, this.child, this.disabledColor = Colors.transparent}): assert(disable != null);

  @override
  Widget build(BuildContext context) {
      return WillPopScope(
        child: Stack(
            children: <Widget>[
              child,
              disable ? Positioned(
                top: 0,
                right: 0,
                bottom: 0,
                left: 0,
                child: Container(
                  color: disabledColor,
                ),
              ) : SizedBox()
            ]
        ),
        onWillPop: () async => !disable,
      );
    }
}