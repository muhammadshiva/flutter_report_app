import 'package:flutter/material.dart';
import 'package:flutter_report_app/shared/styles/color_style.dart';
import 'package:flutter_report_app/shared/styles/google_text_style.dart';

class ButtonWidgetCustom extends StatelessWidget {
  const ButtonWidgetCustom({
    super.key,
    required this.text,
    this.height,
    this.width,
    required this.color,
    this.textColor,
    required this.textStyle,
    required this.onPressed,
  });

  final String text;
  final double? height;
  final double? width;
  final Color color;
  final Color? textColor;
  final TextStyle textStyle;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: color,
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: textStyle.copyWith(
            fontWeight: semiBold,
            color: textColor ?? ColorStyle.white,
          ),
        ),
      ),
    );
  }
}
