import 'dart:async';

import 'package:bas_app/configs/routes/app_route.dart';
import 'package:bas_app/features/bahan_baku/models/bahan_baku_delete_model.dart';
import 'package:bas_app/features/bahan_baku/models/bahan_baku_fetch_model.dart';
import 'package:bas_app/features/bahan_baku/repositories/bahan_baku_repository.dart';
import 'package:bas_app/shared/controllers/global_controller.dart';
import 'package:bas_app/shared/widgets/general/dialog_success_widget.dart';
import 'package:bas_app/utils/services/loading_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BahanBakuController extends GetxController {
  static BahanBakuController get to => Get.find();

  //* Main Value
  BahanBakuData bahanBakuData = BahanBakuData();
  RxList<String> dropdownSumberBatok = RxList([]);
  RxList<String> dropdownBahanBaku = ['Semua', 'Stok Arang', 'Stok Aci', 'Stok Cairan'].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    getBahanBaku();
    super.onInit();
  }

  Future<void> getBahanBaku({String? filter}) async {
    try {
      await GlobalController.to.checkConnection();
      if (GlobalController.to.isConnect.isTrue) {
        isLoading.value = true;

        BahanBakuFetchResponseModel response = await BahanBakuRepository.getBahanBaku(
          filter ?? '',
        );

        if (response.status == 200) {
          bahanBakuData = response.data ?? BahanBakuData();

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

  Future<void> deleteBahanBaku({required int idBahanBaku}) async {
    try {
      await GlobalController.to.checkConnection();
      LoadingService.show();

      if (GlobalController.to.isConnect.isTrue) {
        BahanBakuDeleteResponseModel response = await BahanBakuRepository.deleteBahanBaku(
          idBahanBaku: idBahanBaku,
        );

        if (response.status == 200) {
          LoadingService.dismiss();

          var timer = Timer(const Duration(seconds: 3), () {
            Get.back();
            getBahanBaku();
          });

          DialogSuccess.show(
            status: 'dihapus',
            timer: timer,
            onPressed: () {
              Get.back();
              timer.cancel();
              getBahanBaku();
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
