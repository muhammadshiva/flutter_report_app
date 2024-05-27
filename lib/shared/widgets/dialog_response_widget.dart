import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class DialogResponseWidget extends StatelessWidget {
  final String title;
  final String description;
  final bool isSuccess;
  final bool isInfo;
  final String? buttonLabel;
  final void Function() onPressed;
  final bool dismissable;

  const DialogResponseWidget({
    super.key,
    required this.title,
    required this.description,
    required this.isSuccess,
    this.isInfo = false,
    required this.onPressed,
    this.buttonLabel,
    this.dismissable = true,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => dismissable,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Colors.white,
        alignment: Alignment.center,
        insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 44.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isSuccess
                    ? Icons.check_circle
                    : isInfo
                        ? Icons.info
                        : Icons.error_rounded,
              ),
              SizedBox(height: 16.h),
              Text(
                title,
                style: GoogleFonts.lato()
                    .copyWith(fontSize: 22.sp, color: Colors.grey, fontWeight: FontWeight.w800),
              ),
              Text(
                description,
                style: GoogleFonts.lato()
                    .copyWith(fontSize: 18.sp, color: Colors.grey, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 36.h),
              ElevatedButton(
                onPressed: onPressed,
                child: Text('OK'),
              ),

              // ButtonCostom(
              //   name: buttonLabel ?? "OK",
              //   size: Size(0.w, 0.h),
              //   padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 18.h),
              //   onPressed: onPressed,
              //   borderRadius: 50.r,
              //   textStyle: GoogleTextStyle.fw700.copyWith(
              //     fontSize: 18.sp,
              //     color: ColorStyle.white,
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
