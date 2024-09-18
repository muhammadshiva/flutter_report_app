import 'dart:async';
import 'dart:developer';

import 'package:bas_app/configs/routes/app_route.dart';
import 'package:bas_app/features/ayak_rotari/argument/ayak_rotari_argument.dart';
import 'package:bas_app/features/ayak_rotari/controllers/ayak_rotari_controller.dart';
import 'package:bas_app/features/ayak_rotari/models/ayak_rotari_post_model.dart';
import 'package:bas_app/features/ayak_rotari/repositories/ayak_rotari_repository.dart';
import 'package:bas_app/features/home/controller/home_controller.dart';
import 'package:bas_app/shared/controllers/global_controller.dart';
import 'package:bas_app/shared/widgets/general/dialog_success_widget.dart';
import 'package:bas_app/utils/services/loading_service.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class AyakRotariQueryController extends GetxController {
  static AyakRotariQueryController get to => Get.find();

  //* Main Value
  RxString selectedDropdown = ''.obs;
  RxBool isLoading = false.obs;
  RxBool isEdit = false.obs;
  RxList<String> dropdownSumberBatok = RxList([]);
  RxInt idAyakRotari = 0.obs;

  //* Input String
  RxString tanggalTxt = ''.obs;
  RxString tanggalTxtInit = ''.obs;
  RxString sumberBatokTxt = ''.obs;
  RxString batokMasukTxt = ''.obs;
  RxString batokKotorTxt = ''.obs;
  RxString hasilBatokTxt = ''.obs;
  RxString hasilAbuTxt = ''.obs;
  RxString keteranganTxt = ''.obs;

  //* Error Input String
  RxString tanggalError = ''.obs;
  RxString sumberBatokError = ''.obs;
  RxString batokMasukError = ''.obs;
  RxString batokKotorError = ''.obs;
  RxString hasilBatokError = ''.obs;
  RxString hasilAbuError = ''.obs;
  RxString keteranganError = ''.obs;

  late AyakRotariArgument argument;

  @override
  void onInit() {
    dropdownSumberBatok(HomeController.to.listSumberBatok);

    if (Get.arguments != null) {
      argument = Get.arguments as AyakRotariArgument;
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

    if (batokMasukTxt.value.isEmpty) {
      batokMasukError.value = 'Batok masuk tidak boleh kosong';
      isValid = false;
    } else {
      batokMasukError.value = '';
    }

    if (batokKotorTxt.value.isEmpty) {
      batokKotorError.value = 'Batok kotor tidak boleh kosong';
      isValid = false;
    } else {
      batokKotorError.value = '';
    }

    if (hasilBatokTxt.value.isEmpty) {
      hasilBatokError.value = 'Hasil batok tidak boleh kosong';
      isValid = false;
    } else {
      hasilBatokError.value = '';
    }

    if (hasilAbuTxt.value.isEmpty) {
      hasilAbuError.value = 'Hasil abu tidak boleh kosong';
      isValid = false;
    } else {
      hasilAbuError.value = '';
    }

    if (keteranganTxt.value.isEmpty) {
      keteranganError.value = 'Keterangan tidak boleh kosong';
      isValid = false;
    } else {
      keteranganError.value = '';
    }

    if (isValid) {
      postAyakRotari();
    }
  }

  Future<void> postAyakRotari() async {
    try {
      await GlobalController.to.checkConnection();

      if (GlobalController.to.isConnect.isTrue) {
        LoadingService.show();

        AyakRotariPostResponseModel response =
            await AyakRotariRepository.postAyakRotari(
          idAyakRotari: idAyakRotari.value == 0 ? null : idAyakRotari.value,
          tanggal: tanggalTxt.value,
          sumberBatok: sumberBatokTxt.value,
          batokMasuk: double.parse(batokMasukTxt.value),
          batokKotor: double.parse(batokKotorTxt.value),
          hasilBatok: double.parse(hasilBatokTxt.value),
          hasilAbu: double.parse(hasilAbuTxt.value),
          keterangan: keteranganTxt.value,
        );

        if (response.status == 200) {
          LoadingService.dismiss();

          if (Get.isRegistered<AyakRotariController>()) {
            var timer = Timer(const Duration(seconds: 3), () {
              Get.until(
                  (route) => Get.currentRoute == AppRoute.ayakRotariRoute);
              AyakRotariController.to.getAyakRotari();
            });

            DialogSuccess.show(
              status: isEdit.isTrue ? 'diedit' : 'ditambahkan',
              timer: timer,
              onPressed: () {
                timer.cancel();
                Get.until(
                    (route) => Get.currentRoute == AppRoute.ayakRotariRoute);
                AyakRotariController.to.getAyakRotari();
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
    idAyakRotari.value = argument.listAyakRotari?.id ?? 0;
    isEdit.value = argument.isEdit ?? false;
    tanggalTxt.value = argument.listAyakRotari?.tanggal ?? '2024-01-01';
    tanggalTxtInit.value = GlobalController.to.formatDate(
      argument.listAyakRotari?.tanggal ?? '2024-01-01',
    );
    sumberBatokTxt.value = argument.listAyakRotari?.sumberBatok ?? '';
    batokMasukTxt.value = argument.listAyakRotari?.batokMasuk.toString() ?? '';
    batokKotorTxt.value = argument.listAyakRotari?.batokKotor.toString() ?? '';
    hasilBatokTxt.value = argument.listAyakRotari?.hasilBatok.toString() ?? '';
    hasilAbuTxt.value = argument.listAyakRotari?.hasilAbu.toString() ?? '';
    keteranganTxt.value = argument.listAyakRotari?.keterangan ?? '';
  }
}
