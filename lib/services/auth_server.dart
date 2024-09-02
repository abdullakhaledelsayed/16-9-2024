import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../screens/homepage.dart';
import '../utils/error_handler.dart';

class AuthService {
  final BuildContext context;
  final String baseUrl;

  AuthService(this.context, {this.baseUrl = "https://pms-alpha.nuwas.xyz/api/v1/auth"});

  Future<void> authenticateUser(String endpoint, Map<String, dynamic> data, bool isLogin) async {
    final apiUrl = "$baseUrl/$endpoint";
    final errorHandler = ErrorHandler(context);

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );

      final responseBody = utf8.decode(response.bodyBytes);
      print('Response Body: $responseBody'); // Debugging
      print('Response Status: ${response.statusCode}'); // Debugging

      if (response.statusCode == 200) {
        final responseData = jsonDecode(responseBody);

        if ((isLogin && responseData["status"] == true) ||
            (!isLogin && responseData["success"] == true)) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(isLogin ? "Login successful!" : "Registration successful!")),
          );

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const KeraHomePage()),
          );
        } else {
          errorHandler.handleErrorResponse(responseData["message"]);
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
    }
  }
}
