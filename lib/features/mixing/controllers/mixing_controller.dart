import 'dart:async';

import 'package:bas_app/configs/routes/app_route.dart';
import 'package:bas_app/features/mixing/models/mixing_delete_model.dart';
import 'package:bas_app/features/mixing/models/mixing_fetch_model.dart';
import 'package:bas_app/features/mixing/repositories/mixing_repository.dart';
import 'package:bas_app/shared/controllers/global_controller.dart';
import 'package:bas_app/shared/widgets/general/dialog_success_widget.dart';
import 'package:bas_app/utils/services/loading_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MixingController extends GetxController {
  static MixingController get to => Get.find();

  MixingData mixingData = MixingData();
  RxList<String> dropdownSumberBatok = RxList([]);
  RxBool isLoading = false.obs;
  RxInt totalData = 0.obs;

  @override
  void onInit() {
    getMixing();
    super.onInit();
  }

  Future<void> getMixing({String? filter}) async {
    try {
      await GlobalController.to.checkConnection();
      if (GlobalController.to.isConnect.isTrue) {
        isLoading.value = true;

        MixingFetchResponseModel response = await MixingRepository.getMixing(
          filter ?? '',
        );

        if (response.status == 200) {
          mixingData = response.data ?? MixingData();
          totalData.value = response.data?.listMixing?.length ?? 0;

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

  Future<void> deleteDiskmill({required int idMixing}) async {
    try {
      await GlobalController.to.checkConnection();
      LoadingService.show();

      if (GlobalController.to.isConnect.isTrue) {
        MixingDeleteResponseModel response =
            await MixingRepository.deleteMixing(
          idMixing: idMixing,
        );

        if (response.status == 200) {
          LoadingService.dismiss();

          var timer = Timer(const Duration(seconds: 3), () {
            Get.back();
            getMixing();
          });

          DialogSuccess.show(
            status: 'dihapus',
            timer: timer,
            onPressed: () {
              Get.back();
              timer.cancel();
              getMixing();
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
