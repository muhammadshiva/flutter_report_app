import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:bas_app/configs/routes/app_route.dart';
import 'package:bas_app/features/briket/models/briket_delete_model.dart';
import 'package:bas_app/features/briket/models/briket_fetch_model.dart';
import 'package:bas_app/features/briket/repositories/briket_repository.dart';
import 'package:bas_app/shared/controllers/global_controller.dart';
import 'package:bas_app/shared/widgets/general/dialog_success_widget.dart';
import 'package:bas_app/utils/services/loading_service.dart';
import 'package:bas_app/utils/services/notification_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';

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
        BriketDeleteResponseModel response =
            await BriketRepository.deleteBriket(
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

  Future<void> exportFile() async {
    try {
      await GlobalController.to.checkConnection();
      LoadingService.show();

      if (GlobalController.to.isConnect.isTrue) {
        final response = await BriketRepository.exportBriket();

        if (response?.statusCode == 200) {
          if (await Permission.manageExternalStorage.request().isGranted) {
            final downloadsDirectory = Directory('/storage/emulated/0/BasApp');

            if (!await downloadsDirectory.exists()) {
              await downloadsDirectory.create(recursive: true);
            }

            var filePath = path.join(downloadsDirectory.path, 'briket.xlsx');
            var file = File(filePath);

            int counter = 1;
            while (await file.exists()) {
              filePath =
                  path.join(downloadsDirectory.path, 'briket($counter).xlsx');
              file = File(filePath);
              counter++;
            }

            await file.writeAsBytes(response?.data);

            await NotificationService.showNotification(
              notifId: 8,
              fileName: 'Briket Data',
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
