import 'package:flutter/material.dart';
import 'package:flutter_report_app/shared/styles/color_style.dart';
import 'package:flutter_report_app/shared/styles/google_text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MainRegionalPersentaseWidget extends StatelessWidget {
  const MainRegionalPersentaseWidget({super.key, required this.filterBy});

  final RxString filterBy;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Persentase Perbandingan Sisa',
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
              Wrap(
                runSpacing: 10.w,
                spacing: 10.w,
                children: [
                  persentaseCard('Stok Aci', 20),
                  persentaseCard('Stok Aci', 20),
                ],
              ),
            ],
          ),
        ),
        20.verticalSpace,
        const Divider(
          thickness: 5,
          color: ColorStyle.grey,
        ),
      ],
    );
  }

  Widget persentaseCard(String title, int persentase) {
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
