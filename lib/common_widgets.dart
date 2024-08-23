import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomTextField extends StatelessWidget {
  final TextInputType keyboardType;
  final TextEditingController controller;
  final String hintText;
  final String iconPath;
  final bool obscureText;
  final bool isDateField;
  final BuildContext? context;

  const CustomTextField({
    required this.keyboardType,
    required this.controller,
    required this.hintText,
    required this.iconPath,
    this.obscureText = false,
    this.isDateField = false,
    this.context,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xffE2E2E2)),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
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
                hintStyle: const TextStyle(color: Color(0xffC9C9C9)),
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
// Widget for social login buttons
Widget _buildSocialLoginButton({
  required String hintText,
  required String iconPath,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
    decoration: BoxDecoration(
      border: Border.all(color: const Color(0xffE2E2E2)),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 5),
          child: SvgPicture.asset(
            iconPath,
            width: 16,
            height: 16,
          ),
        ),
        Expanded(
          child: Text(
            hintText,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 10),
          ),
        ),
      ],
    ),
  );
}

Widget kjkljlk({
  required String hintText,
  required String iconPath,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
    decoration: BoxDecoration(
      border: Border.all(color: const Color(0xffE2E2E2)),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 5),
          child: SvgPicture.asset(
            iconPath,
            width: 16,
            height: 16,
          ),
        ),
        Expanded(
          child: Text(
            hintText,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 10),
          ),
        ),
      ],
    ),
  );
}

