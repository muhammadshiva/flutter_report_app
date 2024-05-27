// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_report_app/shared/styles/color_style.dart';
import 'package:flutter_report_app/shared/styles/google_text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TabWidget extends StatelessWidget {
  const TabWidget({
    super.key,
    required this.tabData,
    this.ontap,
  });

  final List<Map<String, dynamic>> tabData;
  final Function()? ontap;

  @override
  Widget build(BuildContext context) {
    var tabIndex = 1;

    return Container(
      margin: EdgeInsets.only(top: 30.h, bottom: 20.h),
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: tabData
            .map((e) => Obx(
                  () => InkWell(
                    onTap: () {
                      tabIndex = e['id'];
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 32.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.r),
                        color: tabIndex == e['id'] ? ColorStyle.primary : ColorStyle.white,
                        border: Border.all(
                          color: ColorStyle.primary,
                        ),
                      ),
                      child: Text(
                        e['tabName'],
                        style: whiteTextStyle.copyWith(
                          fontSize: 10.sp,
                          fontWeight: semiBold,
                          color: tabIndex == e['id'] ? ColorStyle.white : ColorStyle.primary,
                        ),
                      ),
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
