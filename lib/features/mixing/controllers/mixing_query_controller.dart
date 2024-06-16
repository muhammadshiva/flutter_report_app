import 'dart:async';
import 'dart:developer';

import 'package:bas_app/configs/routes/app_route.dart';
import 'package:bas_app/features/mixing/argument/mixing_argument.dart';
import 'package:bas_app/features/mixing/controllers/mixing_controller.dart';
import 'package:bas_app/features/mixing/models/mixing_post_model.dart';
import 'package:bas_app/features/mixing/repositories/mixing_repository.dart';
import 'package:bas_app/shared/controllers/global_controller.dart';
import 'package:bas_app/shared/widgets/general/dialog_success_widget.dart';
import 'package:bas_app/utils/services/loading_service.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class MixingQueryController extends GetxController {
  static MixingQueryController get to => Get.find();

  //* Main Value
  RxString selectedDropdown = ''.obs;
  RxBool isLoading = false.obs;
  RxBool isEdit = false.obs;
  RxList<String> dropdownSumberBatok = RxList([]);
  RxList<String> dropdownUkuranPisau = ['0.2', '0.3'].obs;
  RxInt idMixing = 0.obs;

//* SAMPEL DATA
// {
//     "tanggal" : "2024-06-03",
//     "sumber_batok": "Kalimantan",
//     "ukuran_pisau" : 0.2,
//     "jumlah_arang" :500.0,
//     "jumlah_aci" : 300.0,
//     "jumlah_cairan" : 220.0,
//     "keterangan" : "Tidak ada"
// }
  //* Input String
  RxString tanggalTxt = ''.obs;
  RxString tanggalTxtInit = ''.obs;
  RxString sumberBatokTxt = ''.obs;
  RxString ukuranPisauTxt = ''.obs;
  RxString jumlahArangTxt = ''.obs;
  RxString jumlahAciTxt = ''.obs;
  RxString jumlahCairanTxt = ''.obs;
  RxString keteranganTxt = ''.obs;

  //* Error Input String
  RxString tanggalError = ''.obs;
  RxString sumberBatokError = ''.obs;
  RxString ukuranPisauError = ''.obs;
  RxString jumlahArangError = ''.obs;
  RxString jumlahAciError = ''.obs;
  RxString jumlahCairanError = ''.obs;
  RxString keteranganError = ''.obs;

  late MixingArgument argument;

  @override
  void onInit() {
    dropdownSumberBatok(GlobalController.to.listSumberBatok);

    if (Get.arguments != null) {
      argument = Get.arguments as MixingArgument;
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

    if (ukuranPisauTxt.value.isEmpty) {
      ukuranPisauError.value = 'Tidak boleh kosong';
      isValid = false;
    } else {
      ukuranPisauError.value = '';
    }

    if (jumlahArangTxt.value.isEmpty) {
      jumlahArangError.value = 'Tidak boleh kosong';
      isValid = false;
    } else {
      jumlahArangError.value = '';
    }

    if (jumlahAciTxt.value.isEmpty) {
      jumlahAciError.value = 'Tidak boleh kosong';
      isValid = false;
    } else {
      jumlahAciError.value = '';
    }

    if (jumlahCairanTxt.value.isEmpty) {
      jumlahCairanError.value = 'Tidak boleh kosong';
      isValid = false;
    } else {
      jumlahCairanError.value = '';
    }

    if (keteranganTxt.value.isEmpty) {
      keteranganError.value = 'Tidak boleh kosong';
      isValid = false;
    } else {
      keteranganError.value = '';
    }

    if (isValid) {
      postMixing();
    }
  }

  Future<void> postMixing() async {
    try {
      await GlobalController.to.checkConnection();

      if (GlobalController.to.isConnect.isTrue) {
        LoadingService.show();

        MixingPostResponseModel response = await MixingRepository.postMixing(
          idMixing: idMixing.value == 0 ? null : idMixing.value,
          tanggal: tanggalTxt.value,
          sumberBatok: sumberBatokTxt.value,
          ukuranPisau: ukuranPisauTxt.value,
          jumlahArang: double.parse(jumlahArangTxt.value),
          jumlahAci: double.parse(jumlahAciTxt.value),
          jumlahCairan: double.parse(jumlahCairanTxt.value),
          keterangan: keteranganTxt.value,
        );

        if (response.status == 200) {
          LoadingService.dismiss();

          if (Get.isRegistered<MixingController>()) {
            var timer = Timer(const Duration(seconds: 3), () {
              Get.until((route) => Get.currentRoute == AppRoute.mixingRoute);
              MixingController.to.getMixing();
            });

            DialogSuccess.show(
              status: isEdit.isTrue ? 'diedit' : 'ditambahkan',
              timer: timer,
              onPressed: () {
                timer.cancel();
                Get.until((route) => Get.currentRoute == AppRoute.mixingRoute);
                MixingController.to.getMixing();
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
    idMixing.value = argument.listMixing?.id ?? 0;
    isEdit.value = argument.isEdit ?? false;
    tanggalTxt.value = argument.listMixing?.tanggal ?? '2024-01-01';
    tanggalTxtInit.value = GlobalController.to.formatDate(
      argument.listMixing?.tanggal ?? '2024-01-01',
    );
    sumberBatokTxt.value = argument.listMixing?.sumberBatok ?? '';
    ukuranPisauTxt.value = argument.listMixing?.ukuranPisau.toString() ?? '';
    jumlahArangTxt.value = argument.listMixing?.jumlahArang.toString() ?? '';
    jumlahAciTxt.value = argument.listMixing?.jumlahAci.toString() ?? '';
    jumlahCairanTxt.value = argument.listMixing?.jumlahCairan.toString() ?? '';
    keteranganTxt.value = argument.listMixing?.keterangan ?? '';
  }
}
