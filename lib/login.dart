/*import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'auth_service.dart'; // Import the AuthService
import 'homepage.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;
  final AuthService authService = AuthService();

  Future<void> _login() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await authService.login(
        phoneController.text,
        passwordController.text,
      );

      // Handle successful login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const KeraHomePage()),
      );
    } catch (e) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Add your widgets here
              // Similar to the Register page, use CustomTextField and CustomElevatedButton
              // for the login form.
            ],
          ),
        ),
      ),
    );
  }
}
*/