import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'generated/l10n.dart';
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
  final TextEditingController DateController = TextEditingController();
  final TextEditingController idOrResidenceController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool isLoading = false;

  Future<void> _registerUser() async {
    final String apiUrl = "https://pms-alpha.nuwas.xyz/api/v1/auth/register"; // Replace with your API URL

    if (fullNameController.text.isEmpty || phoneNumberController.text.isEmpty ||
        emailController.text.isEmpty || DateController.text.isEmpty ||
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

    try {
      final nameParts = fullNameController.text.split(' ');
      final data = {
        "first_name": nameParts.isNotEmpty ? nameParts[0] : '',
        "second_name": nameParts.length > 1 ? nameParts[1] : '',
        "third_name": nameParts.length > 2 ? nameParts[2] : '',
        "last_name": nameParts.length > 3 ? nameParts[3] : '',
        "phone_number": phoneNumberController.text,
        "email": emailController.text,
        "date_of_birth": DateController.text,
        "id_or_residence_number": idOrResidenceController.text,
        "password": passwordController.text,
        "password_confirmation": confirmPasswordController.text,
        "device_token": "DeviceToken.token", // Include static device token here
      };

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );

      final responseBody = utf8.decode(response.bodyBytes);
      print('Response Body: $responseBody'); // Print the response body for debugging

      if (response.statusCode == 200) {
        final responseData = jsonDecode(responseBody);

        if (responseData["success"] == true) {  // Ensure a proper check here
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Registration successful!")),
          );

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const KeraHomePage()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(responseData["message"] ?? "Registration failed")),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: ${response.body}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
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
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 68),
                        SvgPicture.asset(
                          'images/logo.svg',
                          width: 107.85,
                          height: 48,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          S.of(context).propertyType,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF112C24),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          S.of(context).searchPrompt,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF6F6F6F),
                          ),
                        ),
                        const SizedBox(height: 24),
                        _buildTextField(
                          controller: fullNameController,
                          hintText: S.of(context).fullName,
                          iconPath: 'images/person.svg',
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          controller: phoneNumberController,
                          hintText: S.of(context).phoneNumber,
                          iconPath: 'images/Flag Code.svg',
                          keyboardType: TextInputType.phone,
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          controller: emailController,
                          hintText: S.of(context).email,
                          iconPath: 'images/email.svg',
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 16),

          _buildTextField(
            controller: DateController,
            hintText: 'Date of birth',
            iconPath: 'images/date.svg',
            keyboardType: TextInputType.datetime,
            isDateField: true,
            context: context, // Pass the context
          ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          controller: idOrResidenceController,
                          hintText: S.of(context).idOrResidenceNumber,
                          keyboardType: TextInputType.number,
                          iconPath: 'images/id.svg',
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          controller: passwordController,
                          hintText: S.of(context).password,
                          iconPath: 'images/password.svg',
                          obscureText: true,
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          controller: confirmPasswordController,
                          hintText: S.of(context).confirmPassword,
                          iconPath: 'images/password.svg',
                          obscureText: true,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: isLoading ? null : _registerUser,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff112C24),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 124),
                            elevation: 0,
                          ),
                          child: isLoading
                              ? const CircularProgressIndicator(color: Colors.white)
                              : Text(
                            S.of(context).login,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text.rich(
                          TextSpan(
                            text: S.of(context).existingUser,
                            style: const TextStyle(
                              color: Color(0xff6F6F6F),
                            ),
                            children: [
                              WidgetSpan(
                                child: SizedBox(
                                  width: 4, // Adjust the width as needed
                                ),
                              ),
                              TextSpan(
                                text: S.of(context).loginPrompt,
                                style: const TextStyle(
                                  color: Color(0xffC69D67),
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const KeraHomePage(),
                                      ),
                                    );
                                  },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Opacity(
                            opacity: 0.7,
                            child: SvgPicture.asset(
                              'images/aa.svg',
                              height: 80,
                              width: MediaQuery.of(context).size.width,
                            ),
                          ),
                        ), // Space at the bottom
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildTextField({
    TextInputType keyboardType = TextInputType.text,
    required TextEditingController controller,
    required String hintText,
    required String iconPath,
    bool obscureText = false,
    EdgeInsetsGeometry containerPadding = const EdgeInsets.symmetric(
      horizontal: 0,
      vertical: 10,
    ),
    bool isDateField = false, // New parameter to indicate if this is a date field
    BuildContext? context, // New parameter for accessing the context
  }) {
    return Container(
      height: 40.0, // Fixed height for the text field container
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xffE2E2E2)),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: containerPadding,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 2, left: 4),
            child: SvgPicture.asset(
              iconPath,
              width: 16,
              height: 16,
            ),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: obscureText,
              keyboardType: keyboardType,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: const TextStyle(
                  color: Color(0xffC9C9C9),
                ),
              ),
              onTap: isDateField && context != null
                  ? () async {
                DateTime? date = DateTime(1900);
                FocusScope.of(context).requestFocus(FocusNode());

                date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100),
                  helpText: 'Select expiry date',
                  fieldLabelText: 'Expiry date',
                  fieldHintText: 'Month/Date/Year',
                  builder: (context, child) {
                    return Theme(
                      data: ThemeData.light().copyWith(
                        colorScheme: const ColorScheme.light(
                          primary: Color(0xFF158443),
                        ),
                      ),
                      child: child!,
                    );
                  },
                );

                if (date != null) {
                  final String formattedDate =
                      "${date.month}/${"${date.year}".substring(2)}";
                  controller.text = formattedDate;
                }
              }
                  : null,
            ),
          ),
        ],
      ),
    );
  }

}
