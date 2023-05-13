import 'package:flutter/material.dart';

class Utils {
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();

  static showSnackBar(String? text) {
    if (text == null) return;

    final snackbar = SnackBar(
      content: Text(text),
      backgroundColor: Colors.grey,
    );
    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackbar);
  }
}

const Color lightBlueAccent = Colors.lightBlueAccent;
