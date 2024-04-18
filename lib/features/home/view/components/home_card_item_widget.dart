import 'package:flutter/material.dart';
import 'package:flutter_report_app/shared/styles/color_style.dart';
import 'package:flutter_report_app/shared/styles/google_text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeCardItemWidget extends StatelessWidget {
  const HomeCardItemWidget({
    super.key,
    required this.title,
    required this.date,
    required this.data,
    required this.assetImage,
    this.onTap,
  });

  final String title;
  final String date;
  final int data;
  final AssetImage assetImage;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 100.h,
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 14.h),
        margin: EdgeInsets.only(bottom: 15.h),
        decoration: BoxDecoration(
          color: ColorStyle.white,
          borderRadius: BorderRadius.circular(5.r),
          boxShadow: const [
            BoxShadow(
              color: Color(0x22000000),
              offset: Offset(0, 1),
              blurRadius: 4,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 84.w,
              height: 75.h,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: assetImage,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: blackTextStyle.copyWith(fontSize: 12.sp),
                ),
                Text(
                  'Terakhir ditambahkan pada $date',
                  style: GoogleFonts.inter().copyWith(
                    fontSize: 9.sp,
                    color: ColorStyle.grey,
                    fontWeight: semiBold,
                  ),
                ),
                const Spacer(),
                Container(
                  alignment: Alignment.center,
                  height: 26.h,
                  width: 67.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.r),
                    border: Border.all(
                      color: ColorStyle.b4,
                    ),
                  ),
                  child: Text(
                    '$data Data',
                    style: blueTextStyle.copyWith(
                      fontSize: 10.sp,
                      fontWeight: semiBold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
