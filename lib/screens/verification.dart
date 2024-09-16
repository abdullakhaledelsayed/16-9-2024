/*import 'package:flutter/material.dart';
import '../services/auth_server.dart';

class VerificationScreen extends StatefulWidget {
  final String? phoneNumber; // Nullable

  const VerificationScreen({Key? key, this.phoneNumber}) : super(key: key);
  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final Auth__Service _authService = Auth__Service();
  bool _isCodeSent = false;

  void _sendCode() async {
    final phoneNumber = _phoneNumberController.text.trim();
    if (phoneNumber.isNotEmpty) {
      await _authService.sendVerificationCode(phoneNumber);
      setState(() {
        _isCodeSent = true;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter a valid phone number")),
      );
    }
  }

  void _verifyCode() {
    final inputCode = _codeController.text.trim();
    if (_authService.verifyCode(inputCode)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Verification successful!")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Invalid verification code")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Phone Number Verification")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _phoneNumberController,
              decoration: InputDecoration(labelText: "Phone Number"),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _sendCode,
              child: Text("Send Verification Code"),
            ),
            if (_isCodeSent) ...[
              SizedBox(height: 32.0),
              TextField(
                controller: _codeController,
                decoration: InputDecoration(labelText: "Enter Verification Code"),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _verifyCode,
                child: Text("Verify Code"),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
*/

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart'; // Add this package for the PinCodeField
import '../common_widgets.dart';
import '../generated/l10n.dart';
import '../services/Apiservice.dart';
import '../services/auth_server.dart';

class VerificationScreen extends StatefulWidget {
  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final apiService = Api__service();

  Future<void> _verifyCode() async {
    final phoneNumber = _phoneNumberController.text;
    final code = _codeController.text;

    await apiService.verifyCode(phoneNumber, code);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Verify Code')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _phoneNumberController,
              decoration: InputDecoration(labelText: 'Phone Number'),
            ),
            TextField(
              controller: _codeController,
              decoration: InputDecoration(labelText: 'Verification Code'),
            ),
            ElevatedButton(
              onPressed: _verifyCode,
              child: Text('Verify Code'),
            ),
          ],
        ),
      ),
    );
  }
}
