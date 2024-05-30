import 'package:flutter/material.dart';
import 'package:flutter_report_app/shared/controllers/global_controller.dart';
import 'package:flutter_report_app/shared/styles/google_text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TextFieldDateWidgetCustom extends StatelessWidget {
  const TextFieldDateWidgetCustom({
    super.key,
    required this.controller,
    required this.errorText,
    this.margin,
  });

  final TextEditingController controller;
  final RxString errorText;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.only(bottom: 25.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            key: key,
            controller: controller,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  10.r,
                ),
              ),
              hintText: 'Pilih Tanggal',
              prefixIcon: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: const Icon(
                  Icons.calendar_month_outlined,
                  color: Color(0xffBBBDC7),
                ),
              ),
            ),
            readOnly: true,
            keyboardType: TextInputType.datetime,
            onTap: () {
              GlobalController.to.selectDate(context);
            },
          ),
          5.verticalSpace,
          Obx(
            () => Visibility(
              visible: errorText.isEmpty ? false : true,
              child: Text(
                errorText.value,
                style: redTextStyle.copyWith(
                  fontSize: 12.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
