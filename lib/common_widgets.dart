import 'package:flutter/gestures.dart';
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

  CustomTextField({
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

Widget buildsocialloginbuttons({
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

class CommonWidget extends StatelessWidget {
  final String title;
  final String subtitle;

  const CommonWidget({
    required this.title,
    required this.subtitle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF112C24),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF6F6F6F),
          ),
        ),
        const SizedBox(height: 24),
        
      ],
    );
  }
}

class BottomAlignedImage extends StatelessWidget {
  final String assetPath;

  const BottomAlignedImage({
    required this.assetPath,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Opacity(
        opacity: 0.7,
        child: SvgPicture.asset(
          assetPath,
          height: 80,
          width: MediaQuery.of(context).size.width,
        ),
      ),
    );
  }
}
class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;
  final String text;

  const CustomElevatedButton({
    required this.onPressed,
    required this.isLoading,
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xff112C24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 128),
        elevation: 0,
      ),
      child: isLoading
          ? const CircularProgressIndicator(color: Colors.white)
          : Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}


class CustomRichText extends StatelessWidget {
  final String mainText;
  final String linkText;
  final VoidCallback onLinkTap;
  final Color textColor;
  final double fontSize;

  const CustomRichText({
    required this.mainText,
    required this.linkText,
    required this.onLinkTap,
    this.textColor = const Color(0xff6F6F6F),
    this.fontSize = 14.0,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.center,
      child: RichText(
        text: TextSpan(
          text: mainText,
          style: TextStyle(color: textColor, fontSize: fontSize),
          children: [
            const WidgetSpan(
              child: SizedBox(width: 4),
            ),
            TextSpan(
              text: linkText,
              style: const TextStyle(color: Color(0xffC69D67), fontSize: 14.0),
              recognizer: TapGestureRecognizer()..onTap = onLinkTap,
            ),
          ],
        ),
      ),
    );
  }
}

class CustomRichTextLink extends StatelessWidget {
  final String text;
  final Color textColor;
  final double fontSize;
  final VoidCallback onTap;

  const CustomRichTextLink({
    required this.text,
    required this.textColor,
    required this.fontSize,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.center,
      child: RichText(
        text: TextSpan(
          text: text,
          style: TextStyle(color: textColor, fontSize: fontSize),
          recognizer: TapGestureRecognizer()..onTap = onTap,
        ),
      ),
    );
  }
}

class CustomRichLink extends StatelessWidget {
  final String text;
  final Color textColor;
  final double fontSize;
  final VoidCallback onTap;

  const CustomRichLink({
    required this.text,
    required this.textColor,
    required this.fontSize,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: RichText(
        text: TextSpan(
          text: text,
          style: TextStyle(color: textColor, fontSize: fontSize),
          recognizer: TapGestureRecognizer()..onTap = onTap,
        ),
      ),
    );
  }
}