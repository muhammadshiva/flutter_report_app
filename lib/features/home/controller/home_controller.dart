import 'dart:async';
import 'dart:developer';

import 'package:bas_app/configs/routes/app_route.dart';
import 'package:bas_app/features/home/model/menu_fetch_model.dart';
import 'package:bas_app/features/home/repositories/home_repository.dart';
import 'package:bas_app/shared/controllers/global_controller.dart';
import 'package:bas_app/shared/model/sumber_batok_fetch_model.dart';
import 'package:bas_app/utils/services/hive_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  RxList<MenuData> listMenuData = RxList([]);
  RxList<String> listSumberBatok = RxList([]);
  RxBool isLoading = false.obs;
  RxString position = ''.obs;
  RxString selectedAdminMenu = ''.obs;
  var tabIndex = 1.obs;

  List<Map<String, dynamic>> tabData = [
    {"id": 1, "tabName": "Pra-Produksi"},
    {"id": 2, "tabName": "Produksi"},
    {"id": 3, "tabName": "Pasca-Produksi"}
  ];

  @override
  void onInit() {
    position.value = HiveService.box.get('position');

    fetchMenu();
    getSumberBatok();
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

          isLoading.value = false;
        } else {
          isLoading.value = false;
          Get.snackbar(
            'Peringatan'.tr,
            response.message ?? 'Terjadi kesalahan',
            backgroundColor: Colors.red.shade300,
            colorText: Colors.white,
            duration: const Duration(seconds: 2),
          );
        }
      } else {
        Get.toNamed(AppRoute.noConnectionRoute);
      }
    } on DioException catch (e) {
      log('ERROR GET BATOK : $e');
    } catch (e) {
      log('ERROR GET BATOK : $e');
    }
  }

  Future<void> getSumberBatok() async {
    try {
      SumberBatokFetchModel response = await HomeRepository.getSumberBatok();

      if (response.status == 200) {
        listSumberBatok(response.data);
        log('LIST SUMBER BATOK : ${listSumberBatok.toString()}');
      } else {
        Get.snackbar(
          'Peringatan'.tr,
          response.message ?? 'Terjadi kesalahan',
          backgroundColor: Colors.red.shade300,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
      }
    } on DioException catch (e) {
      log('ERROR GET SUMBER BATOK : $e');
    } catch (e) {
      log('ERROR GET SUMBER BATOK : $e');
    }
  }

  void logout() async {
    await HiveService.deleteAuth();
    Get.offAllNamed(AppRoute.signInRoute);
  }
}
