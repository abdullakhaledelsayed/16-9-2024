import 'package:first/forgetpassword.dart';
import 'package:flutter/material.dart';

import '../screens/register.dart';

class ErrorHandler {
  final BuildContext context;

  ErrorHandler(this.context);

  void handleErrorResponse(String? errorMessage) {
    if (errorMessage == "this user is not verified") {
      errorMessage =
      "Your account is not verified. Please check your email or phone for verification instructions.";
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const forgetpassword()),
      );
    } else if (errorMessage == "User not found") {
      errorMessage = "User not found, please register first.";
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Register()),
      );
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(errorMessage ?? "An error occurred")),
    );
  }
}
