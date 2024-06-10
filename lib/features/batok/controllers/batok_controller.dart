import 'dart:async';

import 'package:bas_app/configs/routes/app_route.dart';
import 'package:bas_app/features/batok/models/batok_delete_model.dart';
import 'package:bas_app/features/batok/models/batok_fetch_model.dart';
import 'package:bas_app/features/batok/repository/batok_repository.dart';
import 'package:bas_app/shared/controllers/global_controller.dart';
import 'package:bas_app/shared/widgets/general/dialog_success_widget.dart';
import 'package:bas_app/utils/services/loading_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BatokController extends GetxController {
  static BatokController get to => Get.find();

  //* Main Value
  BatokData batokData = BatokData();
  RxList<String> dropdownSumberBatok = RxList([]);
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    getBatok();
    super.onInit();
  }

  Future<void> getBatok({String? filter}) async {
    try {
      await GlobalController.to.checkConnection();
      if (GlobalController.to.isConnect.isTrue) {
        isLoading.value = true;

        BatokFetchResponseModel response = await BatokRepository.getBatok(
          filter ?? '',
        );

        if (response.status == 200) {
          batokData = response.data ?? BatokData();

          if (dropdownSumberBatok.isEmpty) {
            dropdownSumberBatok.addAll(
              [
                'Semua',
                ...(GlobalController.to.listSumberBatok),
              ],
            );
          }

          isLoading.value = false;
        }
      } else {
        isLoading.value = false;
        Get.toNamed(AppRoute.noConnectionRoute);
      }
    } on DioException catch (e) {
      debugPrint('ERROR GET BATOK : $e');
    }
  }

  Future<void> deleteBatok({required int idBatok}) async {
    try {
      await GlobalController.to.checkConnection();
      LoadingService.show();

      if (GlobalController.to.isConnect.isTrue) {
        BatokDeleteResponseModel response = await BatokRepository.deleteBatok(
          idBatok: idBatok,
        );

        if (response.status == 200) {
          LoadingService.dismiss();

          var timer = Timer(const Duration(seconds: 3), () {
            Get.back();
            getBatok();
          });

          DialogSuccess.show(
            status: 'dihapus',
            timer: timer,
            onPressed: () {
              Get.back();
              timer.cancel();
              getBatok();
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
