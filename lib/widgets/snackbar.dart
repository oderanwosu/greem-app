import 'package:flutter/material.dart';

SnackBar buildSnackBarMessage({required String message, required bool error}) {
  return SnackBar(
      duration: Duration(seconds: 20),
      action: SnackBarAction(
        label: 'Close',
        textColor: Colors.red,
        onPressed: (() {}),
      ),
      backgroundColor: Color.fromARGB(255, 255, 225, 225),
      content: Text(message,
          style: TextStyle(
            color: Colors.red,
          )));
}

class SnackBarMessage extends StatelessWidget {
  String message;
  bool error;

  SnackBarMessage({required this.message, required this.error});

  @override
  Widget build(BuildContext context) {
    return SnackBar(
        duration: Duration(seconds: 20),
        action: SnackBarAction(
          label: 'Close',
          textColor: Colors.red,
          onPressed: (() {}),
        ),
        backgroundColor: Color.fromARGB(255, 255, 225, 225),
        content: Text(message,
            style: TextStyle(
              color: Colors.red,
            )));
  }
}
