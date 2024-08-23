import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'generated/l10n.dart';
import 'homepage.dart';

class forgetpassword extends StatefulWidget {
  const forgetpassword({super.key});

  @override
  State<forgetpassword> createState() => _forgetpasswordState();
}

class _forgetpasswordState extends State<forgetpassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body:  SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Center(
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
    const SizedBox(height: 200),
    SvgPicture.asset(
    'images/graphics.svg',
    width: 88,
    height: 88,

    ),
      Text(
        S.of(context).enter_mobile_number,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Color(0xFF112C24),
        ),
      ),
      Text(
        S.of(context).confirmation_code_message,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Color(0xFF6F6F6F),
        ),
      ),
      const SizedBox(height: 24),
      _buildTextField(
        iconPath: 'images/Flag Code.svg',
        hintText: (S.of(context).phoneNumber),
        keyboardType: TextInputType.number,
      ),const SizedBox(height: 239),
      Center(
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff112C24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(
                vertical: 10, horizontal: 14522),
            elevation: 0,
          ),
          child: Text(
            S.of(context).send,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),    ]))
        )
        );} Widget _buildTextField({
    required String hintText,
    required String iconPath,
    bool obscureText = false,
    EdgeInsetsGeometry containerPadding = const EdgeInsets.symmetric(
      horizontal: 0,
      vertical: 10,
    ),
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
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
              obscureText: obscureText,
              keyboardType: keyboardType,
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
                hintStyle: const TextStyle(fontSize: 12),
                contentPadding: EdgeInsets.only(
                    top: 40, bottom: 3), // Remove extra padding if needed
              ),
            ),
          ),
        ],
      ),
    );
  }}

