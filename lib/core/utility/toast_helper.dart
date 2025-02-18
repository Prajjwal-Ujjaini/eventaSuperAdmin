import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class ToastHelper {
  // Show success toast message
  static void showSuccessToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  // Show error toast message
  static void showErrorToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  // Show info toast message
  static void showInfoToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  // Show custom toast message (for more control)
  static void showCustomToast({
    required String message,
    Color backgroundColor = Colors.black,
    Color textColor = Colors.white,
    Toast toastLength = Toast.LENGTH_SHORT,
    ToastGravity gravity = ToastGravity.BOTTOM,
    double fontSize = 16.0,
    int timeInSecForIosWeb = 1,
  }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: toastLength,
      gravity: gravity,
      timeInSecForIosWeb: timeInSecForIosWeb,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: fontSize,
    );
  }
}
