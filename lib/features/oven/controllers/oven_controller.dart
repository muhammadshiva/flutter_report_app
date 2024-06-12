import 'dart:async';

import 'package:bas_app/configs/routes/app_route.dart';
import 'package:bas_app/features/oven/models/oven_delete_model.dart';
import 'package:bas_app/features/oven/models/oven_fetch_model.dart';
import 'package:bas_app/features/oven/repositories/oven_repository.dart';
import 'package:bas_app/shared/controllers/global_controller.dart';
import 'package:bas_app/shared/widgets/general/dialog_success_widget.dart';
import 'package:bas_app/utils/services/loading_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OvenController extends GetxController {
  static OvenController get to => Get.find();

  OvenData ovenData = OvenData();
  RxList<String> dropdownSumberBatok = RxList([]);
  RxBool isLoading = false.obs;
  RxInt totalData = 0.obs;

  @override
  void onInit() {
    getOven();
    super.onInit();
  }

  Future<void> getOven({String? filter}) async {
    try {
      await GlobalController.to.checkConnection();
      if (GlobalController.to.isConnect.isTrue) {
        isLoading.value = true;

        OvenFetchResponseModel response = await OvenRepository.getOven(
          filter ?? '',
        );

        if (response.status == 200) {
          ovenData = response.data ?? OvenData();
          totalData.value = response.data?.listOven?.length ?? 0;

          print('TOTAL DATA : ${totalData.value}');

          if (dropdownSumberBatok.isEmpty) {
            dropdownSumberBatok.addAll(
              [
                'Semua',
                ...(GlobalController.to.listSumberBatok),
              ],
            );
          }

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

  Future<void> deleteOven({required int idOven}) async {
    try {
      await GlobalController.to.checkConnection();
      LoadingService.show();

      if (GlobalController.to.isConnect.isTrue) {
        OvenDeleteResponseModel response = await OvenRepository.deleteOven(
          idOven: idOven,
        );

        if (response.status == 200) {
          LoadingService.dismiss();

          var timer = Timer(const Duration(seconds: 3), () {
            Get.back();
            getOven();
          });

          DialogSuccess.show(
            status: 'dihapus',
            timer: timer,
            onPressed: () {
              Get.back();
              timer.cancel();
              getOven();
            },
          );
        }
      } else if (GlobalController.to.isConnect.value == false) {
        LoadingService.dismiss();
        Get.toNamed(AppRoute.noConnectionRoute);
      }
    } on DioException catch (e, stackTrace) {
      debugPrint('$stackTrace');
    }
  }
}
