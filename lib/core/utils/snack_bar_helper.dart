import 'package:flutter/material.dart';

/// Lives above the router, so a SnackBar shown right before a route change
/// (register -> login, logout -> login) survives the navigation instead of
/// being torn down with the old screen's Scaffold.
final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

extension SnackBarHelper on BuildContext {
  void showSnackBar(String message, {Color? background}) {
    final messenger =
        rootScaffoldMessengerKey.currentState ?? ScaffoldMessenger.of(this);
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(backgroundColor: background, content: Text(message)),
      );
  }

  void showErrorSnackBar(String message, {Color? background}) =>
      showSnackBar(message, background: background);
}
