import 'package:flutter/material.dart';

class AppKeys {
  // Common GlobalKey for navigator state
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  // Common GlobalKey for ScaffoldMessengerState (for Snackbar notifications)
  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
}
