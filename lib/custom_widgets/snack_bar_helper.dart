import 'package:accountant_app/helpers/navigation.dart';
import 'package:flutter/material.dart';

class SnackBarHelper {
  static void showSuccessSnackBar(String message) {
    final snackBar = SnackBar(
      content: Center(
        child: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.green,
      duration: const Duration(seconds: 5),
    );
    ScaffoldMessenger.of(AppNavigator.context).showSnackBar(snackBar);
  }

  static void showErrorSnackBar(String message) {
    final snackBar = SnackBar(
      content: Center(
        child: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 5),
    );
    ScaffoldMessenger.of(AppNavigator.context).showSnackBar(snackBar);
  }
}
