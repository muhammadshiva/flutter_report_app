import 'package:flutter/material.dart';
import 'package:flutter_report_app/features/batok/controllers/batok_controller.dart';
import 'package:flutter_report_app/shared/styles/color_style.dart';
import 'package:flutter_report_app/shared/styles/google_text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BatokTab extends StatelessWidget {
  const BatokTab({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = BatokController.to;

    return Container(
      margin: EdgeInsets.only(top: 30.h, bottom: 20.h),
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: controller.tabData
            .map((e) => Obx(
                  () => InkWell(
                    onTap: () {
                      controller.tabIndex.value = e['id'];
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 32.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.r),
                        color: controller.tabIndex.value == e['id']
                            ? ColorStyle.primary
                            : ColorStyle.white,
                        border: Border.all(
                          color: ColorStyle.primary,
                        ),
                      ),
                      child: Text(
                        e['tabName'],
                        style: whiteTextStyle.copyWith(
                          fontSize: 10.sp,
                          fontWeight: semiBold,
                          color: controller.tabIndex.value == e['id']
                              ? ColorStyle.white
                              : ColorStyle.primary,
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
