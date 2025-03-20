import 'package:flutter/material.dart';

class AppSnackBar {
  static show(BuildContext context, {required String message}) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
}
