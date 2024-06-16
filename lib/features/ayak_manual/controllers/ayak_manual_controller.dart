import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:bas_app/configs/routes/app_route.dart';
import 'package:bas_app/features/ayak_manual/models/ayak_manual_delete_model.dart';
import 'package:bas_app/features/ayak_manual/models/ayak_manual_fetch_model.dart';
import 'package:bas_app/features/ayak_manual/repositories/ayak_manual_repository.dart';
import 'package:bas_app/shared/controllers/global_controller.dart';
import 'package:bas_app/shared/widgets/general/dialog_success_widget.dart';
import 'package:bas_app/utils/services/loading_service.dart';
import 'package:bas_app/utils/services/notification_service.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart' as path;
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class AyakManualController extends GetxController {
  static AyakManualController get to => Get.find();

  AyakManualData ayakManualData = AyakManualData();
  RxList<String> dropdownSumberBatok = RxList([]);
  RxBool isLoading = false.obs;
  RxInt totalData = 0.obs;

  @override
  void onInit() {
    getAyakManual();
    super.onInit();
  }

  Future<void> getAyakManual({String? filter}) async {
    try {
      await GlobalController.to.checkConnection();
      if (GlobalController.to.isConnect.isTrue) {
        isLoading.value = true;

        AyakManualFetchResponseModel response =
            await AyakManualRepository.getAyakManual(
          filter ?? '',
        );

        if (response.status == 200) {
          ayakManualData = response.data ?? AyakManualData();
          totalData.value = response.data?.listAyakManual?.length ?? 0;

          log('TOTAL DATA : ${totalData.value}');

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

  Future<void> deleteAyakManual({required int idAyakManual}) async {
    try {
      await GlobalController.to.checkConnection();
      LoadingService.show();

      if (GlobalController.to.isConnect.isTrue) {
        AyakManualDeleteResponseModel response =
            await AyakManualRepository.deleteAyakManual(
          idAyakManual: idAyakManual,
        );

        if (response.status == 200) {
          LoadingService.dismiss();

          var timer = Timer(const Duration(seconds: 3), () {
            Get.back();
            getAyakManual();
          });

          DialogSuccess.show(
            status: 'dihapus',
            timer: timer,
            onPressed: () {
              Get.back();
              timer.cancel();
              getAyakManual();
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
        final response = await AyakManualRepository.exportAyakManual();

        if (response?.statusCode == 200) {
          if (await Permission.manageExternalStorage.request().isGranted) {
            final downloadsDirectory = Directory('/storage/emulated/0/BasApp');

            if (!await downloadsDirectory.exists()) {
              await downloadsDirectory.create(recursive: true);
            }

            var filePath =
                path.join(downloadsDirectory.path, 'ayak_manual.xlsx');
            var file = File(filePath);

            int counter = 1;
            while (await file.exists()) {
              filePath = path.join(
                  downloadsDirectory.path, 'ayak_manual($counter).xlsx');
              file = File(filePath);
              counter++;
            }

            await file.writeAsBytes(response?.data);

            await NotificationService.showNotification(
              notifId: 3,
              fileName: 'Ayak Manual Data',
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
