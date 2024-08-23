import 'package:flutter/material.dart';
import 'Apiservice.dart';
import 'homepage.dart'; // Import your home page
import 'forgetpassword.dart'; // Import your forget password page
import 'register.dart'; // Import your registration page

class AuthService {
  final ApiService apiService;

  AuthService(this.apiService);

  Future<void> loginOrRegisterUser({
    required BuildContext context,
    required TextEditingController phoneNumberController,
    required TextEditingController passwordController,
    required ValueSetter<bool> setLoadingState,
  }) async {
    if (phoneNumberController.text.isEmpty || passwordController.text.isEmpty) {
      _showSnackBar(context, "Please fill in all fields");
      return;
    }

    setLoadingState(true);

    try {
      final responseData = await apiService.post(
        'auth/login', // Replace with your actual endpoint
        {
          'phoneNumber': phoneNumberController.text,
          'password': passwordController.text,
        },
      );

      if (responseData["status"] == true) {
        _showSnackBar(context, "Login successful!");
        _navigateToHomePage(context);
      } else {
        _handleLoginError(context, responseData["message"]);
      }
    } catch (e) {
      _showSnackBar(context, "Error: $e");
    } finally {
      setLoadingState(false);
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _navigateToHomePage(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const KeraHomePage()),
    );
  }

  void _handleLoginError(BuildContext context, String? errorMessage) {
    if (errorMessage == "this user is not verified") {
      _showSnackBar(context, "Your account is not verified. Please check your email or phone for verification instructions.");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const forgetpassword()),
      );
    } else if (errorMessage == "User not found") {
      _showSnackBar(context, "User not found, please register first.");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Register()),
      );
    } else {
      _showSnackBar(context, errorMessage ?? "Login failed");
    }
  }
}
