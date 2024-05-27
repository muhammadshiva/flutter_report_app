import 'package:flutter/material.dart';
import 'package:flutter_report_app/shared/styles/color_style.dart';
import 'package:flutter_report_app/shared/styles/google_text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BatokFilter extends StatelessWidget {
  const BatokFilter({super.key, required this.totalData});

  final int totalData;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15.h),
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      child: Row(
        children: [
          Text(
            'Data Wilayah',
            style: blackTextStyle.copyWith(
              fontWeight: semiBold,
              fontSize: 14.sp,
              color: ColorStyle.black2,
            ),
          ),
          SizedBox(width: 5.w),
          Text(
            '($totalData Baris)',
            style: blackTextStyle.copyWith(
              fontSize: 12.sp,
              color: const Color(
                0xffA3A3A3,
              ),
            ),
          ),
          const Spacer(),
          SizedBox(
            height: 30.h,
            width: 120.w,
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(21),
                  borderSide: const BorderSide(
                    color: Color(0xffC5C6CC),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(21),
                  borderSide: const BorderSide(color: ColorStyle.primary),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 19.w),
              ),
              value: 'Semua',
              style: blackTextStyle.copyWith(
                color: ColorStyle.black2,
                fontSize: 12.sp,
              ),
              onChanged: (String? newValue) {},
              items: <String>['Semua', 'Sumatera', 'Sulawesi']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
