import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<dynamic> iosShowDialog({
  required BuildContext context,
  required String title,
  required String subTitle,
  required Function onConfirm,
}) {
  return showDialog(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      title: Text(title),
      content: Text(subTitle),
      actions: [
        // TextButton(
        //     onPressed: () {
        //       Navigator.pop(context);
        //     addFunRefuse!();
        //     },
        //     child: Text('cancel')),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
              onConfirm();
            },
            child: Text('ok'))
      ],
    ),
  );
}
