import 'package:flutter/material.dart';
import 'package:flutter_report_app/configs/routes/route.dart';
import 'package:flutter_report_app/features/home/controller/home_controller.dart';
import 'package:flutter_report_app/features/home/view/components/home_card_item_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeDataListWidget extends StatelessWidget {
  const HomeDataListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = HomeController.to;

    return Scrollbar(
      child: Container(
        height: MediaQuery.sizeOf(context).height * 0.75,
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        margin: EdgeInsets.only(top: 35.h),
        child: Obx(
          () => ListView(
            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 6.h),
            children: controller.productionData
                .where(
                  (e) => controller.tabIndex.value == 1
                      ? e['id'] >= 1 && e['id'] <= 2
                      : controller.tabIndex.value == 2
                          ? e['id'] >= 3 && e['id'] <= 8
                          : e['id'] == 9,
                )
                .map(
                  (e) => HomeCardItemWidget(
                    onTap: () {
                      Get.toNamed(
                        e['id'] == 1 ? Routes.batokRoute : Routes.bahanBakuRoute,
                        arguments: {
                          'id': e['id'],
                          'title': e['title'],
                          'tabIndex': controller.tabIndex.value,
                          'persentase': e['persentase'],
                        },
                      );
                    },
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
    );
  }
}
