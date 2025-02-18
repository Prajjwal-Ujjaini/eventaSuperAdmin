import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';

import '../constants/GlobalKeys.dart';

class ConfirmationHelper {
  // Show confirmation dialog with Beamer
  static Future<bool?> showConfirmationDialog({
    required String title,
    required String message,
    String confirmButtonText = "Yes",
    String cancelButtonText = "No",
    Color confirmButtonColor = Colors.green,
    Color cancelButtonColor = Colors.red,
  }) async {
    final context = AppKeys.navigatorKey.currentContext;

    if (context != null) {
      return showDialog<bool>(
        context: context,
        barrierDismissible:
            false, // Prevent closing the dialog by tapping outside
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(foregroundColor: cancelButtonColor),
                onPressed: () {
                  // Dismiss dialog using Beamer
                  Beamer.of(context).beamBack();
                  // Navigator.of(context).pop(false); // Return 'false' when No is pressed
                },
                child: Text(cancelButtonText),
              ),
              TextButton(
                style:
                    TextButton.styleFrom(foregroundColor: confirmButtonColor),
                onPressed: () {
                  // Dismiss dialog using Beamer
                  Beamer.of(context).beamBack();
                  // Navigator.of(context).pop(true); // Return 'true' when Yes is pressed
                },
                child: Text(confirmButtonText),
              ),
            ],
          );
        },
      );
    }
    return null;
  }
}
