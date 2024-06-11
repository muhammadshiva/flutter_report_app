import 'dart:async';

import 'package:bas_app/configs/routes/app_route.dart';
import 'package:bas_app/features/ayak_rotari/models/ayak_rotari_delete_model.dart';
import 'package:bas_app/features/ayak_rotari/models/ayak_rotari_fetch_model.dart';
import 'package:bas_app/features/ayak_rotari/repositories/ayak_rotari_repository.dart';
import 'package:bas_app/shared/controllers/global_controller.dart';
import 'package:bas_app/shared/widgets/general/dialog_success_widget.dart';
import 'package:bas_app/utils/services/loading_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AyakRotariController extends GetxController {
  static AyakRotariController get to => Get.find();

  AyakRotariData ayakRotariData = AyakRotariData();
  RxList<String> dropdownSumberBatok = RxList([]);
  RxBool isLoading = false.obs;
  RxInt totalData = 0.obs;

  @override
  void onInit() {
    getAyakRotari();
    super.onInit();
  }

  Future<void> getAyakRotari({String? filter}) async {
    try {
      await GlobalController.to.checkConnection();
      if (GlobalController.to.isConnect.isTrue) {
        isLoading.value = true;

        AyakRotariFetchResponseModel response =
            await AyakRotariRepository.getAyakRotari(
          filter ?? '',
        );

        if (response.status == 200) {
          ayakRotariData = response.data ?? AyakRotariData();
          totalData.value = response.data?.listAyakRotari?.length ?? 0;

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

  Future<void> deleteAyakRotari({required int idAyakRotari}) async {
    try {
      await GlobalController.to.checkConnection();
      LoadingService.show();

      if (GlobalController.to.isConnect.isTrue) {
        AyakRotariDeleteResponseModel response =
            await AyakRotariRepository.deleteAyakRotari(
          idAyakRotari: idAyakRotari,
        );

        if (response.status == 200) {
          LoadingService.dismiss();

          var timer = Timer(const Duration(seconds: 3), () {
            Get.back();
            getAyakRotari();
          });

          DialogSuccess.show(
            status: 'dihapus',
            timer: timer,
            onPressed: () {
              Get.back();
              timer.cancel();
              getAyakRotari();
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
