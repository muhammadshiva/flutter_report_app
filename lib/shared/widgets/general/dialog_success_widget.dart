import 'dart:async';

import 'package:bas_app/shared/styles/color_style.dart';
import 'package:bas_app/shared/styles/google_text_style.dart';
import 'package:bas_app/shared/widgets/custom_button/button_timer_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DialogSuccess {
  static void show({
    required String status,
    required Timer timer,
    required dynamic Function() onPressed,
  }) {
    showDialog(
      barrierDismissible: false,
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          title: Column(
            children: [
              Icon(
                Icons.check_circle,
                size: 60.w,
                color: ColorStyle.green,
              ),
              SizedBox(height: 10.w),
              Text(
                'Sukses',
                style: GoogleFonts.roboto().copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 18.sp,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 5.w),
              Text(
                'Data berhasil $status',
                style: GoogleFonts.roboto().copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
          actions: [
            ButtonTimerWidget(
              width: double.infinity,
              text: 'OK',
              color: Colors.green,
              textStyle: whiteTextStyle.copyWith(fontSize: 14.sp),
              onPressed: onPressed,
            ),
          ],
        );
      },
    );
  }
}
