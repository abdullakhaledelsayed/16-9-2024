import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../auth_service.dart';
import '../common_widgets.dart';
import '../generated/l10n.dart';
import '../services/auth_server.dart';
import 'register.dart';
import '../forgetpassword.dart';

class KeraHomePage extends StatefulWidget {
  const KeraHomePage({super.key});

  @override
  _KeraHomePageState createState() => _KeraHomePageState();
}

class _KeraHomePageState extends State<KeraHomePage> {
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _loginUser() async {
    if (phoneNumberController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields")),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final data = {
      "phone_number": phoneNumberController.text,
      "password": passwordController.text,
      "device_token": "DeviceToken.token",
    };

    final authService = AuthService(context);
    await authService.authenticateUser("login", data, true);

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            if (_isLoading)
              const Center(
                child: CircularProgressIndicator(),
              )
            else
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CommonWidget(
                        title: S.of(context).appTitle,
                        subtitle: S.of(context).rentalExperience,
                      ),
                      CustomTextField(
                        iconPath: 'images/Flag Code.svg',
                        hintText: S.of(context).phoneNumber,
                        keyboardType: TextInputType.number,
                        controller: phoneNumberController,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        hintText: S.of(context).password,
                        iconPath: 'images/password.svg',
                        obscureText: true,
                        controller: passwordController,
                        keyboardType: TextInputType.text,
                      ),
                      const SizedBox(height: 16),
                      CustomRichLink(
                        text: S.of(context).forgotPassword,
                        textColor: const Color(0xff6F6F6F),
                        fontSize: 10,
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const forgetpassword(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 250),
                      Row(
                        children: [
                          Expanded(
                            child: buildsocialloginbuttons(
                              hintText: S.of(context).loginWithApple,
                              iconPath: 'images/apple.svg',
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                // Your Google login logic here
                              },
                              child: buildsocialloginbuttons(
                                hintText: S.of(context).loginWithGoogle,
                                iconPath: 'images/google.svg',
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      CustomElevatedButton(
                        onPressed: _loginUser,
                        isLoading: _isLoading,
                        text: S.of(context).login,
                      ),

                      const SizedBox(height: 8),
                      CustomRichText(
                        mainText: S.of(context).existingUser,
                        linkText: S.of(context).loginPrompt,
                        onLinkTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Register(),
                            ),
                          );
                        },
                        textColor: const Color(0xff112C24),
                      ),
                      const SizedBox(height: 16),
                      const BottomAlignedImage(assetPath: 'images/aa.svg'),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

