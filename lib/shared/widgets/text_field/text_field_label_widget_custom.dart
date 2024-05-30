import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_report_app/shared/styles/google_text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TextFieldLabelWidgetCustom extends StatelessWidget {
  const TextFieldLabelWidgetCustom({
    super.key,
    this.onChanged,
    required this.controller,
    required this.title,
    this.width,
    required this.errorText,
  });

  final String title;
  final Function(String)? onChanged;
  final TextEditingController controller;
  final double? width;
  final RxString errorText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 25.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style: blackTextStyle.copyWith(
                  fontSize: 12.sp,
                  fontWeight: semiBold,
                  color: const Color(0xffA3A3A3),
                ),
              ),
              20.horizontalSpace,
              Expanded(
                child: TextField(
                  key: key,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  controller: controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        10.r,
                      ),
                    ),
                    suffixIcon: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
                      child: Text(
                        '.Kg',
                        style: blackTextStyle.copyWith(
                          color: const Color(0xffBBBDC7),
                          fontSize: 12.sp,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  onChanged: onChanged,
                  // onChanged: (value) {
                  //   if (value.isNotEmpty) {
                  //     controller.jumlahMasukErrorText.value = '';
                  //   } else {
                  //     controller.jumlahMasukErrorText.value = 'Tidak boleh kosong';
                  //   }
                  // },
                ),
              ),
            ],
          ),
          Obx(
            () => Visibility(
              visible: errorText.isEmpty ? false : true,
              child: Container(
                margin: EdgeInsets.only(top: 10.w),
                child: Text(
                  errorText.value,
                  style: redTextStyle.copyWith(
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
