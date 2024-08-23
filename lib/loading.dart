import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class loading extends StatefulWidget {
  const loading({super.key});

  @override
  State<loading> createState() => _loadingState();
}

class _loadingState extends State<loading> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            backgroundColor: const Color.fromARGB(255, 222, 11, 11),
            body: SafeArea(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                  _buildTextField(
                    iconPath: 'images/logo.svg',
                  ),
                ]))));
  }

  Widget _buildTextField({
    required String iconPath,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: SvgPicture.asset(
        iconPath,
        width: 88,
        height: 88,
      ),
    );
  }
}
