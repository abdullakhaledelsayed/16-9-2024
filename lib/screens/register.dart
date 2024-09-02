import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import '../auth_service.dart';
import '../common_widgets.dart';
import '../generated/l10n.dart';
import '../services/auth_server.dart';
import 'homepage.dart';
class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController idOrResidenceController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool isLoading = false;

  Future<void> _registerUser() async {
    if (fullNameController.text.isEmpty || phoneNumberController.text.isEmpty ||
        emailController.text.isEmpty || dateController.text.isEmpty ||
        idOrResidenceController.text.isEmpty || passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields")),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    final nameParts = fullNameController.text.split(' ');
    final data = {
      "first_name": nameParts.isNotEmpty ? nameParts[0] : '',
      "second_name": nameParts.length > 1 ? nameParts[1] : '',
      "third_name": nameParts.length > 2 ? nameParts[2] : '',
      "last_name": nameParts.length > 3 ? nameParts[3] : '',
      "phone_number": phoneNumberController.text,
      "email": emailController.text,
      "date_of_birth": dateController.text,
      "id_or_residence_number": idOrResidenceController.text,
      "password": passwordController.text,
      "password_confirmation": confirmPasswordController.text,
      "device_token": "DeviceToken.token",
    };

    final authService = AuthService(context);
    await authService.authenticateUser("register", data, false);

    setState(() {
      isLoading = false;
    });
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
              CommonWidget(
                title: S.of(context).propertyType,
                subtitle: S.of(context).searchPrompt,
              ),
              CustomTextField(
                keyboardType: TextInputType.text,
                controller: fullNameController,
                hintText: S.of(context).fullName,
                iconPath: 'images/person.svg',
              ),
              const SizedBox(height: 16),
              CustomTextField(
                keyboardType: TextInputType.phone,
                controller: phoneNumberController,
                hintText: S.of(context).phoneNumber,
                iconPath: 'images/Flag Code.svg',
              ),
              const SizedBox(height: 16),
              CustomTextField(
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                hintText: S.of(context).email,
                iconPath: 'images/email.svg',
              ),
              const SizedBox(height: 16),
              CustomTextField(
                keyboardType: TextInputType.datetime,
                controller: dateController,
                hintText: S.of(context).dateOfBirth,
                iconPath: 'images/date.svg',
                isDateField: true,
                context: context,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                keyboardType: TextInputType.number,
                controller: idOrResidenceController,
                hintText: S.of(context).idOrResidenceNumber,
                iconPath: 'images/id.svg',
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
              CustomTextField(
                keyboardType: TextInputType.text,
                controller: confirmPasswordController,
                hintText: S.of(context).password,
                iconPath: 'images/password.svg',
                obscureText: true,
              ),
              const SizedBox(height: 16),
              CustomElevatedButton(
                onPressed: _registerUser,
                isLoading: isLoading,
                text: S.of(context).send,
              ),
              const SizedBox(height: 8),
              CustomRichText(
                mainText: S.of(context).existingUser,
                linkText: S.of(context).loginPrompt,
                onLinkTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const KeraHomePage(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              const BottomAlignedImage(assetPath: 'images/aa.svg'),
            ],
          ),
        ),
      ),
    );
  }
}