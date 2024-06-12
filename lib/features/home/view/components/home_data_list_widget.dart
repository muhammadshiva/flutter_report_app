import 'package:bas_app/configs/routes/app_route.dart';
import 'package:bas_app/constants/global_asset_constant.dart';
import 'package:bas_app/features/home/controller/home_controller.dart';
import 'package:bas_app/features/home/view/components/home_card_item_widget.dart';
import 'package:bas_app/shared/controllers/global_controller.dart';
import 'package:flutter/material.dart';
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
        child: Obx(() {
          if (controller.isLoading.isTrue) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView(
            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 6.h),
            children: controller.listMenuData
                .where(
                  (e) => controller.tabIndex.value == 1
                      ? e.id! >= 1 && e.id! <= 2
                      : controller.tabIndex.value == 2
                          ? e.id! >= 3 && e.id! <= 7
                          : e.id! == 8,
                )
                .map(
                  (e) => HomeCardItemWidget(
                    title: _getTitleById(e.id),
                    date: GlobalController.to.formatDate(e.dateCreated ?? ''),
                    data: e.total ?? 0,
                    assetImage: _getImageById(e.id),
                    onTap: () {
                      Get.toNamed(_getRouteById(e.id));
                    },
                  ),
                )
                .toList(),
          );
        }),
      ),
    );
  }

  String _getTitleById(int? id) {
    switch (id) {
      case 1:
        return 'Keluar / Masuk Batok';
      case 2:
        return 'Keluar / Masuk Bahan Baku';
      case 3:
        return 'Ayak Manual';
      case 4:
        return 'Ayak Rotari';
      case 5:
        return 'Diskmill';
      case 6:
        return 'Mixing';
      case 7:
        return 'Oven & Cooling';
      case 8:
        return 'Stok Briket';
      default:
        return '';
    }
  }

  AssetImage _getImageById(int? id) {
    switch (id) {
      case 1:
        return const AssetImage(GlobalAssetConstant.imgBatokKelapa);
      case 2:
        return const AssetImage(GlobalAssetConstant.imgBahanBaku);
      case 3:
        return const AssetImage(GlobalAssetConstant.imgAyakManual);
      case 4:
        return const AssetImage(GlobalAssetConstant.imgAyakRotari);
      case 5:
        return const AssetImage(GlobalAssetConstant.imgDiskmill);
      case 6:
        return const AssetImage(GlobalAssetConstant.imgDiskmill);
      case 7:
        return const AssetImage(GlobalAssetConstant.imgSortir);
      default:
        return const AssetImage(GlobalAssetConstant.imgStokBriket);
    }
  }

  String _getRouteById(int? id) {
    switch (id) {
      case 1:
        return AppRoute.batokRoute;
      case 2:
        return AppRoute.bahanBakuRoute;
      case 3:
        return AppRoute.ayakManualRoute;
      case 4:
        return AppRoute.ayakRotariRoute;
      case 5:
        return AppRoute.diskmillRoute;
      case 6:
        return AppRoute.mixingRoute;
      case 7:
        return AppRoute.ovenRoute;
      case 8:
        return AppRoute.briketRoute;
      default:
        return AppRoute.homeRoute;
    }
  }
}
