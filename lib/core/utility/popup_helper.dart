import 'package:flutter/material.dart';

import '../constants/GlobalKeys.dart';

// A global key for showing popups without needing context
class PopupHelper {
  // Show a custom popup with a widget as content
  static void showPopup({
    required Widget content,
    String? title,
    String? confirmButtonText,
    String? cancelButtonText,
    Function()? onConfirm,
    Function()? onCancel,
  }) {
    final context = AppKeys.scaffoldMessengerKey.currentContext;

    if (context != null) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: title != null ? Text(title) : null,
            content: content,
            actions: [
              if (cancelButtonText != null)
                TextButton(
                  onPressed: () {
                    onCancel?.call();
                    Navigator.pop(context); // Close the dialog
                  },
                  child: Text(cancelButtonText),
                ),
              if (confirmButtonText != null)
                TextButton(
                  onPressed: () {
                    onConfirm?.call();
                    Navigator.pop(context); // Close the dialog
                  },
                  child: Text(confirmButtonText),
                ),
            ],
          );
        },
      );
    }
  }

  // Show a simple confirmation dialog with a message
  static void showConfirmationPopup({
    required String message,
    String confirmButtonText = 'OK',
    String cancelButtonText = 'Cancel',
    Function()? onConfirm,
    Function()? onCancel,
  }) {
    showPopup(
      content: Text(message),
      confirmButtonText: confirmButtonText,
      cancelButtonText: cancelButtonText,
      onConfirm: onConfirm,
      onCancel: onCancel,
    );
  }

  // Show a loading dialog with a custom message
  static void showLoadingPopup(String message) {
    showPopup(
      content: Row(
        children: [
          CircularProgressIndicator(),
          SizedBox(width: 16),
          Text(message),
        ],
      ),
      confirmButtonText: 'OK',
      onConfirm: () {
        Navigator.pop(AppKeys.scaffoldMessengerKey.currentContext!);
      },
    );
  }
}
