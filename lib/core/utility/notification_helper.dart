import 'package:flutter/material.dart';

import '../constants/GlobalKeys.dart';

class NotificationHelper {
  // Show success notification
  static void showSuccessNotification(String message) {
    AppKeys.scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 3),
      ),
    );
  }

  // Show error notification
  static void showErrorNotification(String message) {
    AppKeys.scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      ),
    );
  }

  // Show info notification
  static void showInfoNotification(String message) {
    AppKeys.scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.blue,
        duration: Duration(seconds: 3),
      ),
    );
  }

  // Show custom notification (for more control)
  static void showCustomNotification({
    required String message,
    Color backgroundColor = Colors.black,
    Duration duration = const Duration(seconds: 3),
  }) {
    AppKeys.scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        duration: duration,
      ),
    );
  }
}
