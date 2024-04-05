import 'package:flutter/material.dart';
import 'package:flutter_report_app/constants/global_asset_constant.dart';
import 'package:flutter_report_app/features/home/controller/home_controller.dart';
import 'package:flutter_report_app/features/home/view/components/card_item_widget.dart';
import 'package:flutter_report_app/shared/styles/color_style.dart';
import 'package:flutter_report_app/shared/styles/google_text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = HomeController.to;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Proses Produksi',
          style: blackTextStyle.copyWith(
            fontSize: 18.sp,
            fontWeight: semiBold,
          ),
        ),
        actions: [
          Container(
            height: 22.h,
            margin: EdgeInsets.only(right: 12.w),
            child: Image.asset(
              GlobalAssetConstant.imgLogoBas,
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          SizedBox(height: 35.h),
          Padding(
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
                              color: controller.tabIndex.value == e['id'] ? ColorStyle.primary : ColorStyle.white,
                              border: Border.all(
                                color: ColorStyle.primary,
                              ),
                            ),
                            child: Text(
                              e['tabName'],
                              style: whiteTextStyle.copyWith(
                                fontSize: 10.sp,
                                fontWeight: semiBold,
                                color: controller.tabIndex.value == e['id'] ? ColorStyle.white : ColorStyle.primary,
                              ),
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
          SizedBox(height: 35.h),
          Scrollbar(
            child: Container(
              height: MediaQuery.sizeOf(context).height * 0.75,
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Obx(
                () => controller.tabIndex.value == 1
                    ? ListView(
                        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 6.h),
                        children: controller.praProduksiData
                            .map(
                              (e) => CardItemWidget(
                                title: e['title'],
                                date: '28 Maret, 2023',
                                data: 0,
                                assetImage: e['image'],
                              ),
                            )
                            .toList(),
                      )
                    : controller.tabIndex.value == 2
                        ? ListView(
                            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 6.h),
                            children: controller.produksiData
                                .map(
                                  (e) => CardItemWidget(
                                    title: e['title'],
                                    date: '28 Maret, 2023',
                                    data: 0,
                                    assetImage: e['image'],
                                  ),
                                )
                                .toList(),
                          )
                        : ListView(
                            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 6.h),
                            children: controller.pascaProduksiData
                                .map(
                                  (e) => CardItemWidget(
                                    title: e['title'],
                                    date: '28 Maret, 2023',
                                    data: 0,
                                    assetImage: e['image'],
                                  ),
                                )
                                .toList(),
                          ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
