import 'package:bas_app/configs/routes/app_route.dart';
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
        await GlobalController.to.getSumberBatok();

        if (response.status == 200) {
          listMenuData(response.data);

          isLoading.value = false;
        } else {
          isLoading.value = false;
          Get.toNamed(AppRoute.noConnectionRoute);
        }
      } else {
        Get.toNamed(AppRoute.noConnectionRoute);
      }
    } on DioException catch (e) {
      debugPrint('ERROR GET BATOK : $e');
    }
  }

  void logout() async {
    HomeRepository.logout();
    await HiveService.deleteAuth();
    Get.offAllNamed(AppRoute.signInRoute);
  }
}
