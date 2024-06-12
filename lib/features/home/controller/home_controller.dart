import 'package:bas_app/configs/routes/app_route.dart';
import 'package:bas_app/constants/global_asset_constant.dart';
import 'package:bas_app/features/home/model/menu_fetch_model.dart';
import 'package:bas_app/features/home/repositories/home_repository.dart';
import 'package:bas_app/shared/controllers/global_controller.dart';
import 'package:bas_app/utils/services/hive_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  RxList<MenuData> listMenuData = RxList([]);
  RxBool isLoading = false.obs;
  var tabIndex = 1.obs;

  var batok = 0.obs;

  List<Map<String, dynamic>> tabData = [
    {"id": 1, "tabName": "Pra-Produksi"},
    {"id": 2, "tabName": "Produksi"},
    {"id": 3, "tabName": "Pasca-Produksi"}
  ];

  @override
  void onInit() {
    fetchMenu();
    super.onInit();
  }

  Future<void> fetchMenu({String? filter}) async {
    try {
      await GlobalController.to.checkConnection();
      if (GlobalController.to.isConnect.isTrue) {
        isLoading.value = true;

        MenuFetchResponseModel response = await HomeRepository.fetchMenu();

        if (response.status == 200) {
          listMenuData(response.data);

          batok.value = listMenuData.indexOf('batok');

          isLoading.value = false;
        } else {
          isLoading.value = false;
          Get.toNamed(AppRoute.noConnectionRoute);
        }
      }
    } on DioException catch (e) {
      debugPrint('ERROR GET BATOK : $e');
    }
  }

  List<Map<String, dynamic>> productionData = [
    {
      "id": 1,
      "title": "Keluar / Masuk Batok",
      "image": const AssetImage(GlobalAssetConstant.imgBatokKelapa),
      "total_data": 0,
    },
    {
      "id": 2,
      "title": "Keluar / Masuk Bahan Baku",
      "image": const AssetImage(GlobalAssetConstant.imgBahanBaku),
      "total_data": 0
    },
    {
      "id": 3,
      "title": "Ayak Manual",
      "image": const AssetImage(GlobalAssetConstant.imgAyakManual),
      "total_data": 0
    },
    {
      "id": 4,
      "title": "Ayak Rotari",
      "image": const AssetImage(GlobalAssetConstant.imgAyakRotari),
      "total_data": 0
    },
    {
      "id": 5,
      "title": "Proses Diskmill",
      "image": const AssetImage(GlobalAssetConstant.imgDiskmill),
      "total_data": 0
    },
    {
      "id": 6,
      "title": "Proses Mixing",
      "image": const AssetImage(GlobalAssetConstant.imgDiskmill),
      "total_data": 0
    },
    {
      "id": 7,
      "title": "Proses Pengovenan",
      "image": const AssetImage(GlobalAssetConstant.imgSortir),
      "total_data": 0
    },
    {
      "id": 8,
      "title": "Stok Briket",
      "image": const AssetImage(GlobalAssetConstant.imgStokBriket),
      "total_data": 0,
    },
  ];

  void updateProductionData() {
    // Loop through productionData to update total_data based on listMenuData
    for (var item in productionData) {
      var count =
          listMenuData.where((menu) => menu.title == item['title']).length;
      item['total_data'] = count;
    }
  }

  void logout() async {
    HomeRepository.logout();
    await HiveService.deleteAuth();
    Get.offAllNamed(AppRoute.signInRoute);
  }
}
