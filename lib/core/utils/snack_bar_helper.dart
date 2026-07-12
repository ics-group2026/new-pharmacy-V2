import 'package:flutter/material.dart';

extension SnackBarHelper on BuildContext {
  void showSnackBar(String message, {Color? background}) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(backgroundColor: background, content: Text(message)),
      );
  }

  void showErrorSnackBar(String message, {Color? background}) =>
      showSnackBar(message, background: background);
}
