import 'dart:async';

import 'package:bas_app/configs/routes/app_route.dart';
import 'package:bas_app/features/briket/models/briket_delete_model.dart';
import 'package:bas_app/features/briket/models/briket_fetch_model.dart';
import 'package:bas_app/features/briket/repositories/briket_repository.dart';
import 'package:bas_app/shared/controllers/global_controller.dart';
import 'package:bas_app/shared/widgets/general/dialog_success_widget.dart';
import 'package:bas_app/utils/services/loading_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BriketController extends GetxController {
  static BriketController get to => Get.find();

  BriketData briketData = BriketData();
  RxList<String> dropdownSumberBatok = RxList([]);
  RxBool isLoading = false.obs;
  RxInt totalData = 0.obs;

  @override
  void onInit() {
    getBriket();
    super.onInit();
  }

  Future<void> getBriket({String? filter}) async {
    try {
      await GlobalController.to.checkConnection();
      if (GlobalController.to.isConnect.isTrue) {
        isLoading.value = true;

        BriketFetchResponseModel response = await BriketRepository.getBriket(
          filter ?? '',
        );

        if (response.status == 200) {
          briketData = response.data ?? BriketData();
          totalData.value = response.data?.listBriket?.length ?? 0;

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

  Future<void> deleteBriket({required int idBriket}) async {
    try {
      await GlobalController.to.checkConnection();
      LoadingService.show();

      if (GlobalController.to.isConnect.isTrue) {
        BriketDeleteResponseModel response = await BriketRepository.deleteOven(
          idBriket: idBriket,
        );

        if (response.status == 200) {
          LoadingService.dismiss();

          var timer = Timer(const Duration(seconds: 3), () {
            Get.back();
            getBriket();
          });

          DialogSuccess.show(
            status: 'dihapus',
            timer: timer,
            onPressed: () {
              Get.back();
              timer.cancel();
              getBriket();
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
