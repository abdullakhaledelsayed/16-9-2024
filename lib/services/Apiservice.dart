/*import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<Map<String, dynamic>> login(String phone, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'phone': phone,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body); // Parse response
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<Map<String, dynamic>> register(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body); // Parse response
    } else {
      throw Exception('Failed to register');
    }
  }
}
*/
/*
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String baseUrl;
  late final http.Client httpClient;

  ApiService(this.baseUrl) {
    httpClient = http.Client();
  }

  Future<Map<String, dynamic>> _get(String endpoint) async {
    final response = await httpClient.get(Uri.parse('$baseUrl/$endpoint'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<Map<String, dynamic>> _post(String endpoint, Map<String, dynamic> body) async {
    final response = await httpClient.post(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(body),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to post data');
    }
  }

  Future<Map<String, dynamic>> _put(String endpoint, Map<String, dynamic> body) async {
    final response = await httpClient.put(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(body),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to update data');
    }
  }

  Future<Map<String, dynamic>> _delete(String endpoint) async {
    final response = await httpClient.delete(Uri.parse('$baseUrl/$endpoint'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to delete data');
    }
  }

  // Example method for login
  Future<Map<String, dynamic>> login(String email, String password) async {
    final body = {'email': email, 'password': password};
    return await _post('auth/login', body);
  }

  // Example method for registration
  Future<Map<String, dynamic>> register({
    required String fullName,
    required String phoneNumber,
    required String email,
    required String dateOfBirth,
    required String idOrResidenceNumber,
    required String password,
  }) async {
    final body = {
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'email': email,
      'dateOfBirth': dateOfBirth,
      'idOrResidenceNumber': idOrResidenceNumber,
      'password': password,
    };
    return await _post('auth/register', body);
  }

  // Example method for fetching user data
  Future<Map<String, dynamic>> getUser(String userId) async {
    return await _get('users/$userId');
  }

  // Example method for updating user data
  Future<Map<String, dynamic>> updateUser(String userId, Map<String, dynamic> updates) async {
    return await _put('users/$userId', updates);
  }

  // Example method for deleting user data
  Future<Map<String, dynamic>> deleteUser(String userId) async {
    return await _delete('users/$userId');
  }
}*/


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final BuildContext context;

  ApiService(this.context);

  Future<Map<String, dynamic>?> makePostRequest(String url, Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );

      final responseBody = utf8.decode(response.bodyBytes);
      print('Response Body: $responseBody');
      print('Response Status: ${response.statusCode}');

      if (response.statusCode == 200) {
        return jsonDecode(responseBody);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: ${response.body}")),
        );
        return null;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
      return null;
    }
  }
}
