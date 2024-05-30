import 'package:flutter/material.dart';
import 'package:flutter_report_app/shared/styles/color_style.dart';
import 'package:flutter_report_app/shared/styles/google_text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainRegionalCardWidget extends StatelessWidget {
  const MainRegionalCardWidget({super.key, required this.onTap});

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 15.h),
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade200),
          borderRadius: BorderRadius.circular(5.r),
          boxShadow: [
            BoxShadow(
              color: const Color(0xff000000).withOpacity(0.1),
              offset: const Offset(0, 2),
              blurRadius: 10,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Lorem',
              style: blackTextStyle.copyWith(
                color: ColorStyle.black2,
                fontWeight: semiBold,
                fontSize: 14.sp,
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Row(
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Stok ',
                        style: blackTextStyle.copyWith(
                          color: ColorStyle.black2,
                          fontSize: 10.sp,
                        ),
                      ),
                      TextSpan(
                        text: ' ${20.25}%',
                        style: TextStyle(
                          color: ColorStyle.bb3,
                          fontWeight: medium,
                          fontSize: 10.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              // 'Terakhir ditambahkan pada ${controller.formatDate(date: data.tanggal ?? '')}',
              '29 Mei 2024',
              style: blackTextStyle.copyWith(
                color: const Color(0xffA3A3A3),
                fontSize: 10.sp,
                fontWeight: medium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
