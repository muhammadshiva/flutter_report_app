import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:bas_app/configs/routes/app_route.dart';
import 'package:bas_app/features/bahan_baku/models/bahan_baku_delete_model.dart';
import 'package:bas_app/features/bahan_baku/models/bahan_baku_fetch_model.dart';
import 'package:bas_app/features/bahan_baku/repositories/bahan_baku_repository.dart';
import 'package:bas_app/shared/controllers/global_controller.dart';
import 'package:bas_app/shared/widgets/general/dialog_success_widget.dart';
import 'package:bas_app/utils/services/loading_service.dart';
import 'package:bas_app/utils/services/notification_service.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';

class BahanBakuController extends GetxController {
  static BahanBakuController get to => Get.find();

  //* Main Value
  BahanBakuData bahanBakuData = BahanBakuData();
  RxList<String> dropdownSumberBatok = RxList([]);
  RxList<String> dropdownBahanBaku =
      ['Semua', 'Stok Arang', 'Stok Aci', 'Stok Cairan'].obs;
  RxBool isLoading = false.obs;
  RxInt totalData = 0.obs;

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

        BahanBakuFetchResponseModel response =
            await BahanBakuRepository.getBahanBaku(
          filter ?? '',
        );

        if (response.status == 200) {
          bahanBakuData = response.data ?? BahanBakuData();
          totalData.value = response.data?.listBahanBaku?.length ?? 0;

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
      log('ERROR GET BATOK : $e');
    }
  }

  Future<void> deleteBahanBaku({required int idBahanBaku}) async {
    try {
      await GlobalController.to.checkConnection();
      LoadingService.show();

      if (GlobalController.to.isConnect.isTrue) {
        BahanBakuDeleteResponseModel response =
            await BahanBakuRepository.deleteBahanBaku(
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
      log('$stackTrace');
    }
  }

  Future<void> exportFile() async {
    try {
      await GlobalController.to.checkConnection();
      LoadingService.show();

      if (GlobalController.to.isConnect.isTrue) {
        final response = await BahanBakuRepository.exportBahanBaku();

        if (response?.statusCode == 200) {
          if (await Permission.manageExternalStorage.request().isGranted) {
            final downloadsDirectory = Directory('/storage/emulated/0/BasApp');

            if (!await downloadsDirectory.exists()) {
              await downloadsDirectory.create(recursive: true);
            }

            var filePath =
                path.join(downloadsDirectory.path, 'bahan_baku.xlsx');
            var file = File(filePath);

            int counter = 1;
            while (await file.exists()) {
              filePath = path.join(
                  downloadsDirectory.path, 'bahan_baku($counter).xlsx');
              file = File(filePath);
              counter++;
            }

            await file.writeAsBytes(response?.data);

            await NotificationService.showNotification(
              notifId: 2,
              fileName: 'Bahan Baku Data',
              filePath: filePath,
            );

            log('FILE PATH DOWNLOAD : $filePath');
            log('DOWNLOAD SUCCESS');

            LoadingService.dismiss();
          }
        }
      } else {
        LoadingService.dismiss();
        Get.toNamed(AppRoute.noConnectionRoute);
      }
    } on DioException catch (e) {
      log('ERROR EXPORT FILE : $e');
    }
  }
}
