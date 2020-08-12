import 'package:flutter/material.dart';

class RoundedScaffold extends StatelessWidget {
  final Widget child;
  final AppBar appBar;
  final Drawer drawer;
  final Drawer endDrawer;
  final BottomSheet bottomSheet;
  final List<Color> appbarColors;

  RoundedScaffold({
    this.child,
    this.appBar,
    this.drawer,
    this.endDrawer,
    this.bottomSheet,
    this.appbarColors
  }) : assert(appbarColors != null && appbarColors.length > 0);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: 150,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: appbarColors
              )
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20)
              )
            ),
            child: Container(
              child: child,
            ),
          ),
          drawer: drawer,
          appBar: AppBar(
            title: appBar.title,
            actions: appBar.actions,
            leading: appBar.leading,
            centerTitle: false,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          endDrawer: endDrawer,
          bottomSheet: bottomSheet,
        )
      ],
    );
  }

}