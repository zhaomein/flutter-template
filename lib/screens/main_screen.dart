import 'package:com.kaiyouit.caiwai/widgets/no_scroll_behavior.dart';
import 'package:com.kaiyouit.caiwai/widgets/rounded_scaffold.dart';
import 'package:com.kaiyouit.caiwai/language.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MainScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return RoundedScaffold(
        appBar: AppBar(
          title: Text("Hello"),
        ),
        appbarColors: [Colors.green, Colors.red],
    );
  }
}