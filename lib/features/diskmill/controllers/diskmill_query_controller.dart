import 'dart:async';
import 'dart:developer';

import 'package:bas_app/configs/routes/app_route.dart';
import 'package:bas_app/features/diskmill/argument/diskmill_argument.dart';
import 'package:bas_app/features/diskmill/controllers/diskmill_controller.dart';
import 'package:bas_app/features/diskmill/models/diskmill_post_model.dart';
import 'package:bas_app/features/diskmill/repositories/diskmill_repository.dart';
import 'package:bas_app/features/home/controller/home_controller.dart';
import 'package:bas_app/shared/controllers/global_controller.dart';
import 'package:bas_app/shared/widgets/general/dialog_success_widget.dart';
import 'package:bas_app/utils/services/loading_service.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class DiskmillQueryController extends GetxController {
  static DiskmillQueryController get to => Get.find();

  //* Main Value
  RxString selectedDropdown = ''.obs;
  RxBool isLoading = false.obs;
  RxBool isEdit = false.obs;
  RxList<String> dropdownSumberBatok = RxList([]);
  RxInt idDiskmill = 0.obs;

  //* Input String
  RxString tanggalTxt = ''.obs;
  RxString tanggalTxtInit = ''.obs;
  RxString sumberBatokTxt = ''.obs;
  RxString batokMasukTxt = ''.obs;
  RxString hasilPisau02Txt = ''.obs;
  RxString hasilPisau03Txt = ''.obs;
  RxString keteranganTxt = ''.obs;

  //* Error Input String
  RxString tanggalError = ''.obs;
  RxString sumberBatokError = ''.obs;
  RxString batokMasukError = ''.obs;
  RxString hasilPisau02Error = ''.obs;
  RxString hasilPisau03Error = ''.obs;
  RxString keteranganError = ''.obs;

  late DiskmillArgument argument;

  @override
  void onInit() {
    dropdownSumberBatok(HomeController.to.listSumberBatok);

    if (Get.arguments != null) {
      argument = Get.arguments as DiskmillArgument;
      if (argument.isEdit == true) {
        initEdit();
      }
    }

    super.onInit();
  }

  void validateForm() {
    bool isValid = true;

    if (tanggalTxt.value.isEmpty) {
      tanggalError.value = 'Tidak boleh kosong';
      isValid = false;
    } else {
      tanggalError.value = '';
    }

    if (sumberBatokTxt.value.isEmpty) {
      sumberBatokError.value = 'Tidak boleh kosong';
      isValid = false;
    } else {
      sumberBatokError.value = '';
    }

    if (batokMasukTxt.value.isEmpty) {
      batokMasukError.value = 'Tidak boleh kosong';
      isValid = false;
    } else {
      batokMasukError.value = '';
    }

    if (hasilPisau02Txt.value.isEmpty) {
      hasilPisau02Error.value = 'Tidak boleh kosong';
      isValid = false;
    } else {
      hasilPisau02Error.value = '';
    }

    if (hasilPisau03Txt.value.isEmpty) {
      hasilPisau03Error.value = 'Tidak boleh kosong';
      isValid = false;
    } else {
      hasilPisau03Error.value = '';
    }

    if (keteranganTxt.value.isEmpty) {
      keteranganError.value = 'Tidak boleh kosong';
      isValid = false;
    } else {
      keteranganError.value = '';
    }

    if (isValid) {
      postDiskmill();
    }
  }

  Future<void> postDiskmill() async {
    try {
      await GlobalController.to.checkConnection();

      if (GlobalController.to.isConnect.isTrue) {
        LoadingService.show();

        DiskmillPostResponseModel response =
            await DiskmillRepository.postDiskmill(
          idDiskmill: idDiskmill.value == 0 ? null : idDiskmill.value,
          tanggal: tanggalTxt.value,
          sumberBatok: sumberBatokTxt.value,
          batokMasuk: double.parse(batokMasukTxt.value),
          hasilPisau02: double.parse(hasilPisau02Txt.value),
          hasilPisau03: double.parse(hasilPisau03Txt.value),
          keterangan: keteranganTxt.value,
        );

        if (response.status == 200) {
          LoadingService.dismiss();

          if (Get.isRegistered<DiskmillController>()) {
            var timer = Timer(const Duration(seconds: 3), () {
              Get.until((route) => Get.currentRoute == AppRoute.diskmillRoute);
              DiskmillController.to.getDiskmill();
            });

            DialogSuccess.show(
              status: isEdit.isTrue ? 'diedit' : 'ditambahkan',
              timer: timer,
              onPressed: () {
                timer.cancel();
                Get.until(
                    (route) => Get.currentRoute == AppRoute.diskmillRoute);
                DiskmillController.to.getDiskmill();
              },
            );
          }
        } else {
          String? errorMessage;
          if (response.message?.isNotEmpty == true) {
            errorMessage = response.message;
          }
          LoadingService.dismiss();

          Get.snackbar(
            'Failed',
            errorMessage ?? 'Create Event Failed',
          );
        }
      } else if (GlobalController.to.isConnect.value == false) {
        LoadingService.dismiss();
        Get.toNamed(AppRoute.noConnectionRoute);
      }
    } on DioException catch (e, stackTrace) {
      log('$stackTrace');
      log('try $e');
    }
  }

  void initEdit() {
    idDiskmill.value = argument.listDiskmill?.id ?? 0;
    isEdit.value = argument.isEdit ?? false;
    tanggalTxt.value = argument.listDiskmill?.tanggal ?? '2024-01-01';
    tanggalTxtInit.value = GlobalController.to.formatDate(
      argument.listDiskmill?.tanggal ?? '2024-01-01',
    );
    sumberBatokTxt.value = argument.listDiskmill?.sumberBatok ?? '';
    batokMasukTxt.value = argument.listDiskmill?.batokMasuk.toString() ?? '';
    hasilPisau02Txt.value =
        argument.listDiskmill?.hasilPisau02.toString() ?? '';
    hasilPisau03Txt.value =
        argument.listDiskmill?.hasilPisau03.toString() ?? '';
    keteranganTxt.value = argument.listDiskmill?.keterangan ?? '';
  }
}
