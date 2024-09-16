import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';  // Import the package

import '../common_widgets.dart';

class VerificationCodeInput extends StatelessWidget {
  final bool isError;
  final String phoneNumber;
  final String timerText;
  final VoidCallback onResend;

  const VerificationCodeInput({
    Key? key,
    required this.isError,
    required this.phoneNumber,
    required this.timerText,
    required this.onResend,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _onBackPressed() {
      // Your custom action here
      print('Back button pressed!');
      // Navigate back to the previous screen
      Navigator.pop(context);
    }

    return Scaffold(
        appBar: CustomAppBar(
          title: '',
          onBackPressed: _onBackPressed,
        ),
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'تم إرسال رسالة لرقم جوال $phoneNumber',
                      style: TextStyle(
                        color: isError ? Colors.red : Colors.black,
                      ),
                    ),
                    SizedBox(height: 16),
                    PinCodeTextField(
                      length: 6,
                      obscureText: false,
                      animationType: AnimationType.scale,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 40,
                        inactiveFillColor: Colors.white,
                        activeFillColor: Colors.white,
                        selectedFillColor: Colors.white,
                        inactiveColor: isError ? Colors.red : Colors.grey,
                        activeColor: isError ? Colors.red : Colors.green,
                        selectedColor: Colors.blue,
                      ),
                      cursorColor: Colors.black,
                      animationDuration: Duration(milliseconds: 300),
                      enableActiveFill: true,
                      onChanged: (value) {},
                      onCompleted: (value) {
                        // Handle the completion of the code input
                        print('Code entered: $value');
                      },
                      appContext: context,  // Use the context from the build method
                    ),
                    SizedBox(height: 16),
                    Text(
                      isError ? 'الكود غير صحيح' : timerText,
                      style: TextStyle(
                        color: isError ? Colors.red : Colors.green,
                      ),
                    ),
                    if (!isError)
                      TextButton(
                        onPressed: onResend,
                        child: Text(
                          'إرسال الكود مرة أخرى؟',
                          style: TextStyle(decoration: TextDecoration.underline),
                        ),
                      ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VerificationCodeInput(
                              isError: false,
                              phoneNumber: '',
                              timerText: '30',
                              onResend: () {},
                            ),
                          ),
                        );
                      },
                      child: const Text('تأكيد'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isError ? Colors.grey : Colors.green,
                      ),
                    ),
                  ],
                ))));
  }
}
