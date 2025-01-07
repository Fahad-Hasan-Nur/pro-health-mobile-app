import 'package:flutter/material.dart';

Future<void> showMyDialog(
    BuildContext context, String title, String? text) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // false= user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(text!),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
