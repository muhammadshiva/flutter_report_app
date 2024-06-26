import 'dart:async';

import 'package:bas_app/shared/styles/color_style.dart';
import 'package:bas_app/shared/styles/google_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonTimerWidget extends StatefulWidget {
  const ButtonTimerWidget({
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
  State<ButtonTimerWidget> createState() => _ButtonTimerWidgetState();
}

class _ButtonTimerWidgetState extends State<ButtonTimerWidget> {
  Timer timer = Timer(const Duration(), () {});
  int start = 3;

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.color,
        ),
        onPressed: widget.onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            Text(
              widget.text,
              style: widget.textStyle.copyWith(
                fontWeight: semiBold,
                color: widget.textColor ?? ColorStyle.white,
              ),
            ),
            start == 0
                ? const SizedBox()
                : Text(
                    '$start',
                    style: widget.textStyle.copyWith(
                      fontWeight: semiBold,
                      color: widget.textColor ?? ColorStyle.white,
                      fontSize: 12.sp,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
