import 'dart:async';
import 'dart:developer';

import 'package:bas_app/configs/routes/app_route.dart';
import 'package:bas_app/features/batok/argument/batok_argument.dart';
import 'package:bas_app/features/batok/controllers/batok_controller.dart';
import 'package:bas_app/features/batok/models/batok_post_model.dart';
import 'package:bas_app/features/batok/repository/batok_repository.dart';
import 'package:bas_app/shared/controllers/global_controller.dart';
import 'package:bas_app/shared/widgets/general/dialog_success_widget.dart';
import 'package:bas_app/utils/services/loading_service.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class BatokQueryController extends GetxController {
  static BatokQueryController get to => Get.find();

  //* Main Value
  RxString selectedDropdown = ''.obs;
  RxBool isLoading = false.obs;
  RxBool isEdit = false.obs;
  RxList<String> dropdownSumberBatok = RxList([]);
  RxInt idBatok = 0.obs;

  //* Input String
  RxString jenisInputTxt = ''.obs;
  RxString tanggalTxt = ''.obs;
  RxString tanggalTxtInit = ''.obs;
  RxString sumberBatokTxt = ''.obs;
  RxString jumlahBatokTxt = ''.obs;
  RxString keteranganTxt = ''.obs;

  //* Error Input String
  RxString jenisInputError = ''.obs;
  RxString tanggalError = ''.obs;
  RxString sumberBatokError = ''.obs;
  RxString jumlahBatokError = ''.obs;
  RxString keteranganError = ''.obs;

  late BatokArgument argument;

  @override
  void onInit() {
    dropdownSumberBatok(GlobalController.to.listSumberBatok);

    if (Get.arguments != null) {
      argument = Get.arguments as BatokArgument;
      if (argument.isEdit == true) {
        initEdit();
      }
    }

    super.onInit();
  }

  Future<void> postBatok() async {
    try {
      await GlobalController.to.checkConnection();

      if (GlobalController.to.isConnect.isTrue) {
        LoadingService.show();

        BatokPostResponseModel response = await BatokRepository.postBatok(
          idBatok: idBatok.value == 0 ? null : idBatok.value,
          tanggal: tanggalTxt.value,
          jenisMasukan: jenisInputTxt.value,
          sumberBatok: sumberBatokTxt.value,
          jumlahBatok: double.parse(jumlahBatokTxt.value),
          keterangan: keteranganTxt.value,
        );

        if (response.status == 200) {
          LoadingService.dismiss();

          if (Get.isRegistered<BatokController>()) {
            var timer = Timer(const Duration(seconds: 3), () {
              Get.until((route) => Get.currentRoute == AppRoute.batokRoute);
              BatokController.to.getBatok();
            });

            DialogSuccess.show(
              status: isEdit.isTrue ? 'diedit' : 'ditambahkan',
              timer: timer,
              onPressed: () {
                timer.cancel();
                Get.until((route) => Get.currentRoute == AppRoute.batokRoute);
                BatokController.to.getBatok();
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
    isEdit.value = argument.isEdit ?? false;
    idBatok.value = argument.listBatokData?.id ?? 0;
    jenisInputTxt.value = argument.listBatokData?.jenisMasukan ?? '';
    tanggalTxtInit.value = GlobalController.to.formatDate(
      argument.listBatokData?.tanggal ?? '2024-01-01',
    );
    tanggalTxt.value = argument.listBatokData?.tanggal ?? '2024-01-01';

    sumberBatokTxt.value = argument.listBatokData?.sumberBatok ?? '';
    jumlahBatokTxt.value = argument.listBatokData?.jumlahBatok.toString() ?? '';
    keteranganTxt.value = argument.listBatokData?.keterangan ?? '';
  }

  void validateForm() {
    bool isValid = true;
    if (jenisInputTxt.value.isEmpty) {
      jenisInputError.value = 'Jenis input tidak boleh kosong';
      isValid = false;
    } else {
      jenisInputError.value = '';
    }

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

    if (jumlahBatokTxt.value.isEmpty) {
      jumlahBatokError.value = 'Jumlah batok tidak boleh kosong';
      isValid = false;
    } else {
      jumlahBatokError.value = '';
    }

    if (keteranganTxt.value.isEmpty) {
      keteranganError.value = 'Keterangan tidak boleh kosong';
      isValid = false;
    } else {
      keteranganError.value = '';
    }

    if (isValid) {
      postBatok();
    }
  }

  void clearForm() {
    jenisInputError.value = '';
    tanggalError.value = '';
    sumberBatokError.value = '';
    jumlahBatokError.value = '';
    keteranganError.value = '';
    isEdit.value = false;
  }
}
