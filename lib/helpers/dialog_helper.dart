import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../language.dart';

Future<void> showAlertDialog({context, title, message}) async {
  assert(context != null);

  await showDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text(AppLg.of(context).trans('ok')),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      )
  );
}
