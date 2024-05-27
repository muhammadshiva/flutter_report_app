import 'package:flutter/material.dart';
import 'package:flutter_report_app/features/bahan_baku/controllers/bahan_baku_controller.dart';
import 'package:flutter_report_app/features/home/controller/home_controller.dart';
import 'package:flutter_report_app/shared/styles/color_style.dart';
import 'package:flutter_report_app/shared/styles/google_text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BahanBakuPersentase extends StatelessWidget {
  const BahanBakuPersentase({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var controller = BahanBakuController.to;
    var homeController = HomeController.to;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Text(
            'Persentase Perbandingan Sisa',
            style: blackTextStyle.copyWith(
              fontWeight: medium,
              fontSize: 14.sp,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Text(
            'Mingguan',
            style: greyTextStyle.copyWith(
              fontSize: 12.sp,
              fontWeight: medium,
              color: ColorStyle.grey2,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 20.h, bottom: 15.h),
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Obx(
            () => Column(
              children: homeController.productionData
                  .map(
                    (data) => Wrap(
                      runSpacing: 10.h,
                      spacing: 10.w,
                      children: (data['persentase'] as List<dynamic>).map(
                        (persentaseData) {
                          if (data['id'] == controller.idMenu.value) {
                            return persentaseCard(
                              persentaseData['title'],
                              persentaseData['subtitle'],
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                      ).toList(),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
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
