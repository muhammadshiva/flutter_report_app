import 'package:flutter/material.dart';
import 'package:flutter_report_app/shared/styles/color_style.dart';
import 'package:flutter_report_app/shared/styles/google_text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DropDownFormFieldCustom extends StatelessWidget {
  const DropDownFormFieldCustom({
    super.key,
    this.onChanged,
    this.items,
    required this.errorText,
    this.margin,
  });

  final Function(String?)? onChanged;
  final List<DropdownMenuItem<String>>? items;
  final RxString errorText;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.only(bottom: 25.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 45.h,
            child:
                // Obx(
                //   () =>

                DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: const BorderSide(
                    color: Color(0xffC5C6CC),
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: const BorderSide(
                    color: ColorStyle.primary,
                  ),
                ),
              ),
              hint: Text(
                'Pilih Sumber Batok',
                style: blackTextStyle.copyWith(
                  fontSize: 14.sp,
                  fontWeight: semiBold,
                  color: ColorStyle.black2,
                ),
              ),
              // value: controller.sumberBatok.isNotEmpty
              //     ? controller.listSumberBatok.firstWhere(
              //         (element) => element == controller.sumberBatok.value,
              //       )
              //     : null,
              style: blackTextStyle.copyWith(
                color: ColorStyle.black2,
                fontSize: 13.sp,
              ),
              // onChanged: (String? value) {
              //   controller.sumberBatok.value = value ?? '';
              //   controller.sumberBatokErrorText.value = '';
              // },
              onChanged: onChanged,
              // items: controller.listSumberBatok.map<DropdownMenuItem<String>>(
              //   (String value) {
              //     return DropdownMenuItem<String>(
              //       value: value,
              //       child: Text(
              //         value,
              //         style: blackTextStyle.copyWith(
              //           fontSize: 14.sp,
              //           fontWeight: semiBold,
              //           color: ColorStyle.black2,
              //         ),
              //       ),
              //     );
              //   },
              // ).toList(),
              items: items,
            ),
            // ),
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
