import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:bas_app/configs/routes/app_route.dart';
import 'package:bas_app/features/batok/models/batok_delete_model.dart';
import 'package:bas_app/features/batok/models/batok_fetch_model.dart';
import 'package:bas_app/features/batok/repository/batok_repository.dart';
import 'package:bas_app/features/home/controller/home_controller.dart';
import 'package:bas_app/shared/controllers/global_controller.dart';
import 'package:bas_app/shared/widgets/general/dialog_success_widget.dart';
import 'package:bas_app/utils/services/loading_service.dart';
import 'package:bas_app/utils/services/notification_service.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';

class BatokController extends GetxController {
  static BatokController get to => Get.find();

  //* Main Value
  BatokData batokData = BatokData();
  RxList<String> dropdownSumberBatok = RxList([]);
  RxBool isLoading = false.obs;
  RxInt totalData = 0.obs;

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
          totalData.value = response.data?.listBatok?.length ?? 0;

          if (dropdownSumberBatok.isEmpty) {
            dropdownSumberBatok.addAll(
              [
                'Semua',
                ...(HomeController.to.listSumberBatok),
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
      log('ERROR GET BATOK : $e');
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
      log('$stackTrace');
    }
  }

  Future<void> exportFile() async {
    try {
      await GlobalController.to.checkConnection();
      LoadingService.show();

      if (GlobalController.to.isConnect.isTrue) {
        final response = await BatokRepository.exportBatok();

        if (response?.statusCode == 200) {
          if (await Permission.manageExternalStorage.request().isGranted) {
            final downloadsDirectory = Directory('/storage/emulated/0/BasApp');

            if (!await downloadsDirectory.exists()) {
              await downloadsDirectory.create(recursive: true);
            }

            var filePath = path.join(downloadsDirectory.path, 'batok.xlsx');
            var file = File(filePath);

            int counter = 1;
            while (await file.exists()) {
              filePath =
                  path.join(downloadsDirectory.path, 'batok($counter).xlsx');
              file = File(filePath);
              counter++;
            }

            await file.writeAsBytes(response?.data);

            await NotificationService.showNotification(
              notifId: 1,
              fileName: 'Batok Data',
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
