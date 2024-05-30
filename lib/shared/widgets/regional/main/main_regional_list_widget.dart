import 'package:flutter/material.dart';
import 'package:flutter_report_app/shared/styles/color_style.dart';
import 'package:flutter_report_app/shared/styles/google_text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MainRegionalListWidget extends StatelessWidget {
  const MainRegionalListWidget({
    super.key,
    required this.isLoading,
    this.onRefresh,
    required this.itemCount,
    required this.itemBuilder,
  });

  final RxBool isLoading;
  final Future<void> Function()? onRefresh;
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15.h),
      child: Column(
        children: [
          Padding(
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
                  '(10 Baris)',
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
          ),
          Container(
            margin: EdgeInsets.only(top: 14.h),
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: Scrollbar(
              child: Container(
                height: MediaQuery.sizeOf(context).height * 0.5,
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Obx(
                  () {
                    if (isLoading.isTrue) {
                      return Center(
                        child: Text(
                          'Data kosong',
                          style: GoogleFonts.poppins(),
                        ),
                      );
                    }

                    return RefreshIndicator(
                      onRefresh: onRefresh ?? () async {},
                      child: ListView.builder(
                        itemCount: itemCount,
                        itemBuilder: itemBuilder,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
