// ignore_for_file: must_be_immutable

import 'package:bas_app/shared/styles/color_style.dart';
import 'package:bas_app/shared/styles/google_text_style.dart';
import 'package:bas_app/shared/widgets/custom_widget/tab_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PersentaseBatokWidget<T> extends StatelessWidget {
  PersentaseBatokWidget({
    super.key,
    required this.data,
  });

  RxList<T> data;

  @override
  Widget build(BuildContext context) {
    RxString filterBy = 'Mingguan'.obs;

    return Column(
      children: [
        TabWidget(
          onTabChanged: (index, value) {
            filterBy.value = value;
          },
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total Akumulasi',
                style: blackTextStyle.copyWith(
                  fontWeight: medium,
                  fontSize: 14.sp,
                ),
              ),
              Obx(
                () => Text(
                  filterBy.value,
                  style: greyTextStyle.copyWith(
                    fontSize: 12.sp,
                    fontWeight: medium,
                    color: ColorStyle.grey2,
                  ),
                ),
              ),
              12.verticalSpace,
              Obx(
                () => Wrap(
                  runSpacing: 10.w,
                  spacing: 10.w,
                  children: [
                    for (var i in data) ...[
                      // Assuming T has a method or property `listPersentase` that returns a list
                      for (var j in (i as dynamic).listPersentase!) ...[
                        persentaseCard(j.tipe ?? '', j.persentase ?? 0),
                      ],
                    ]
                  ],
                ),
              ),
            ],
          ),
        ),
        10.verticalSpace,
        const Divider(
          thickness: 5,
          color: ColorStyle.grey,
        ),
      ],
    );
  }

  Widget persentaseCard(String title, double persentase) {
    return Container(
      height: 57.h,
      width: 150.w,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorStyle.grey2,
        ),
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: blackTextStyle.copyWith(
              fontSize: 10.sp,
              color: ColorStyle.black2,
            ),
          ),
          const Spacer(),
          Text(
            '$persentase %',
            style: blackTextStyle.copyWith(
              fontSize: 15.sp,
              fontWeight: semiBold,
              color: ColorStyle.bb3,
            ),
          ),
        ],
      ),
    );
  }
}
