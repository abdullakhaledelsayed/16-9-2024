/*import 'apiservice.dart';

class AuthService {
  final ApiService _apiService = ApiService(baseUrl: 'https://yourapi.com'); // Replace with your API base URL

  Future<Map<String, dynamic>> login(String phone, String password) async {
    try {
      final response = await _apiService.(phone, password);
      return response;
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  Future<Map<String, dynamic>> register(Map<String, dynamic> data) async {
    try {
      final response = await _apiService.register(data);
      return response;
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }
}
*/
/*
import 'dart:convert';
import 'package:http/http.dart' as http;

// Define a class to handle authentication requests
class AuthService {
  final String apiUrl = 'https://example.com/api'; // Replace with your actual API URL

  // Function to register a new user
  Future<Map<String, dynamic>> registerUser({
    required String fullName,
    required String email,
    required String password,
    required String phoneNumber,
    required String userType,
  }) async {
    final Uri url = Uri.parse('$apiUrl/register'); // Update endpoint if necessary

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'fullName': fullName,
          'email': email,
          'password': password,
          'phoneNumber': phoneNumber,
          'userType': userType,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body); // Handle response as needed
      } else {
        throw Exception('Failed to register user: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Error during registration: $e');
    }
  }

  // Function to log in a user
  Future<Map<String, dynamic>> loginUser({
    required String email,
    required String password,
  }) async {
    final Uri url = Uri.parse('$apiUrl/login'); // Update endpoint if necessary

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body); // Handle response as needed
      } else {
        throw Exception('Failed to log in: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Error during login: $e');
    }
  }
}

// Usage example:
// final authService = AuthService();
// final result = await authService.registerUser(
//   fullName: 'John Doe',
//   email: 'john@example.com',
//   password: 'password123',
//   phoneNumber: '1234567890',
//   userType: 'customer',
// );
*/