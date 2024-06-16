import 'dart:async';
import 'dart:developer';

import 'package:bas_app/configs/routes/app_route.dart';
import 'package:bas_app/features/ayak_manual/argument/ayak_manual_argument.dart';
import 'package:bas_app/features/ayak_manual/controllers/ayak_manual_controller.dart';
import 'package:bas_app/features/ayak_manual/models/ayak_manual_post_model.dart';
import 'package:bas_app/features/ayak_manual/repositories/ayak_manual_repository.dart';
import 'package:bas_app/shared/controllers/global_controller.dart';
import 'package:bas_app/shared/widgets/general/dialog_success_widget.dart';
import 'package:bas_app/utils/services/loading_service.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class AyakManualQueryController extends GetxController {
  static AyakManualQueryController get to => Get.find();

  //* Main Value
  RxString selectedDropdown = ''.obs;
  RxBool isLoading = false.obs;
  RxBool isEdit = false.obs;
  RxList<String> dropdownSumberBatok = RxList([]);
  RxInt idAyakManual = 0.obs;

  //* Input String
  RxString tanggalTxt = ''.obs;
  RxString tanggalTxtInit = ''.obs;
  RxString sumberBatokTxt = ''.obs;
  RxString batokTxt = ''.obs;
  RxString batokMentahTxt = ''.obs;
  RxString granulTxt = ''.obs;
  RxString keteranganTxt = ''.obs;

  //* Error Input String
  RxString tanggalError = ''.obs;
  RxString sumberBatokError = ''.obs;
  RxString batokError = ''.obs;
  RxString batokMentahError = ''.obs;
  RxString granulError = ''.obs;
  RxString keteranganError = ''.obs;

  late AyakManualArgument argument;

  @override
  void onInit() {
    dropdownSumberBatok(GlobalController.to.listSumberBatok);

    if (Get.arguments != null) {
      argument = Get.arguments as AyakManualArgument;
      if (argument.isEdit == true) {
        initEdit();
      }
    }

    super.onInit();
  }

  void validateForm() {
    bool isValid = true;
    if (tanggalTxt.value.isEmpty) {
      tanggalError.value = 'Tanggal tidak boleh kosong';
      isValid = false;
    } else {
      tanggalError.value = '';
    }

    if (sumberBatokTxt.value.isEmpty) {
      sumberBatokError.value = 'Sumber batok tidak boleh kosong';
      isValid = false;
    } else {
      sumberBatokError.value = '';
    }

    if (batokTxt.value.isEmpty) {
      batokError.value = 'Batok tidak boleh kosong';
      isValid = false;
    } else {
      batokError.value = '';
    }

    if (batokMentahTxt.value.isEmpty) {
      batokMentahError.value = 'Batok Mentah tidak boleh kosong';
      isValid = false;
    } else {
      batokMentahError.value = '';
    }

    if (granulTxt.value.isEmpty) {
      granulError.value = 'Granul tidak boleh kosong';
      isValid = false;
    } else {
      granulError.value = '';
    }

    if (keteranganTxt.value.isEmpty) {
      keteranganError.value = 'Keterangan tidak boleh kosong';
      isValid = false;
    } else {
      keteranganError.value = '';
    }

    if (isValid) {
      postAyakManual();
    }
  }

  Future<void> postAyakManual() async {
    try {
      await GlobalController.to.checkConnection();

      if (GlobalController.to.isConnect.isTrue) {
        LoadingService.show();

        AyakManualPostResponseModel response =
            await AyakManualRepository.postAyakManual(
          idAyakManual: idAyakManual.value == 0 ? null : idAyakManual.value,
          tanggal: tanggalTxt.value,
          sumberBatok: sumberBatokTxt.value,
          jumlahBatok: double.parse(batokTxt.value),
          jumlahBatokMentah: double.parse(batokMentahTxt.value),
          jumlahGranul: double.parse(granulTxt.value),
          keterangan: keteranganTxt.value,
        );

        if (response.status == 200) {
          LoadingService.dismiss();

          if (Get.isRegistered<AyakManualController>()) {
            var timer = Timer(const Duration(seconds: 3), () {
              Get.until(
                  (route) => Get.currentRoute == AppRoute.ayakManualRoute);
              AyakManualController.to.getAyakManual();
            });

            DialogSuccess.show(
              status: isEdit.isTrue ? 'diedit' : 'ditambahkan',
              timer: timer,
              onPressed: () {
                timer.cancel();
                Get.until(
                    (route) => Get.currentRoute == AppRoute.ayakManualRoute);
                AyakManualController.to.getAyakManual();
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
    idAyakManual.value = argument.listAyakManual?.id ?? 0;
    isEdit.value = argument.isEdit ?? false;
    tanggalTxt.value = argument.listAyakManual?.tanggal ?? '2024-01-01';
    tanggalTxtInit.value = GlobalController.to.formatDate(
      argument.listAyakManual?.tanggal ?? '2024-01-01',
    );
    sumberBatokTxt.value = argument.listAyakManual?.sumberBatok ?? '';
    batokTxt.value = argument.listAyakManual?.jumlahBatok.toString() ?? '';
    batokMentahTxt.value =
        argument.listAyakManual?.jumlahBatokMentah.toString() ?? '';
    granulTxt.value = argument.listAyakManual?.jumlahGranul.toString() ?? '';
    keteranganTxt.value = argument.listAyakManual?.keterangan ?? '';
  }
}
