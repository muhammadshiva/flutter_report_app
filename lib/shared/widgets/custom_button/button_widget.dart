import 'package:bas_app/shared/styles/color_style.dart';
import 'package:bas_app/shared/styles/google_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.text,
    this.height,
    this.width,
    required this.color,
    this.textColor,
    required this.textStyle,
    required this.onPressed,
    this.icon,
    this.iconColor,
    this.iconSize,
  });

  final String text;
  final double? height;
  final double? width;
  final Color color;
  final Color? textColor;
  final TextStyle textStyle;
  final Function() onPressed;
  final String? icon;
  final Color? iconColor;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (icon != null) ...[
              SvgPicture.asset(
                icon ?? '',
                height: iconSize ?? 20.w,
                color: iconColor ?? Colors.white,
              ),
              10.horizontalSpace,
            ],
            Text(
              text,
              style: textStyle.copyWith(
                fontWeight: semiBold,
                color: textColor ?? ColorStyle.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
