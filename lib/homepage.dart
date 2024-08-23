import 'package:first/Apiservice.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'auth_service.dart'; // Import the API service
import 'generated/l10n.dart';
import 'register.dart';
import 'forgetpassword.dart';
import 'common_widgets.dart'; // Import the common widgets file

class KeraHomePage extends StatefulWidget {
  const KeraHomePage({super.key});

  @override
  _KeraHomePageState createState() => _KeraHomePageState();
}

class _KeraHomePageState extends State<KeraHomePage> {
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isLoading = false;
  late AuthService authService;

  @override
  void initState() {
    super.initState();
    final apiService = ApiService("https://pms-alpha.nuwas.xyz/api/v1"); // Base URL
    authService = AuthService(apiService);
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
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 68),
                      SvgPicture.asset(
                        'images/logo.svg',
                        width: 107.85,
                        height: 48,
                      ),
                      Text(
                        S.of(context).appTitle,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF112C24),
                        ),
                      ),
                      Text(
                        S.of(context).rentalExperience,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF6F6F6F),
                        ),
                      ),
                      const SizedBox(height: 24),
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
                      const SizedBox(height: 4),
                      Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: RichText(
                          text: TextSpan(
                            text: S.of(context).forgotPassword,
                            style: const TextStyle(color: Color(0xff6F6F6F), fontSize: 10),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const forgetpassword()),
                                );
                              },
                          ),
                        ),
                      ),
                      const SizedBox(height: 273),
                      Row(
                        children: [
                          Expanded(
                            child: kjkljlk(
                              hintText: 'Login with Apple', // Replace with S.of(context).loginWithApple for localization
                              iconPath: 'images/apple.svg',
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                // Your Google login logic here
                              },
                              child: kjkljlk(
                                hintText: 'Login with Google', // Replace with S.of(context).loginWithGoogle for localization
                                iconPath: 'images/google.svg',
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          await _handleLogin();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff112C24),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 120),
                        ),
                        child: Center(
                          child: Text(
                            S.of(context).login,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Center(
                        child: RichText(
                          text: TextSpan(
                            text: S.of(context).newUser,
                            style: const TextStyle(color: Colors.grey),
                            children: [
                              TextSpan(
                                text: S.of(context).createAccount,
                                style: const TextStyle(
                                  color: Color(0xffC69D67),
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Register()),
                                    );
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Opacity(
                          opacity: 0.8,
                          child: SvgPicture.asset(
                            'images/aa.svg',
                            height: 96.21,
                            width: double.infinity,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleLogin() async {
    setState(() {
      _isLoading = true;
    });

    await authService.loginOrRegisterUser(
      context: context,
      phoneNumberController: phoneNumberController,
      passwordController: passwordController,
      setLoadingState: (bool isLoading) {
        setState(() {
          _isLoading = isLoading;
        });
      },
    );
  }
}
