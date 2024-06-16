import 'dart:async';
import 'dart:developer';

import 'package:bas_app/configs/routes/app_route.dart';
import 'package:bas_app/features/briket/argument/briket_argument.dart';
import 'package:bas_app/features/briket/controllers/briket_controller.dart';
import 'package:bas_app/features/briket/models/briket_post_model.dart';
import 'package:bas_app/features/briket/repositories/briket_repository.dart';
import 'package:bas_app/shared/controllers/global_controller.dart';
import 'package:bas_app/shared/widgets/general/dialog_success_widget.dart';
import 'package:bas_app/utils/services/loading_service.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class BriketQueryController extends GetxController {
  static BriketQueryController get to => Get.find();

  //* Main Value
  RxString selectedDropdown = ''.obs;
  RxBool isLoading = false.obs;
  RxBool isEdit = false.obs;
  RxList<String> dropdownSumberBatok = RxList([]);
  RxList<String> grades = ['Grade A', 'Grade B', 'Grade C'].obs;
  RxString selectedInputType = ''.obs;
  RxInt idBriket = 0.obs;

  //* Input String
  RxString jenisMasukanTxt = ''.obs;
  RxString tanggalTxt = ''.obs;
  RxString tanggalTxtInit = ''.obs;
  RxString sumberBatokTxt = ''.obs;
  RxString jenisBriketTxt = ''.obs;
  RxString stokTxt = ''.obs;
  RxString keteranganTxt = ''.obs;

  //* Error Input String
  RxString jenisMasukanError = ''.obs;
  RxString tanggalError = ''.obs;
  RxString sumberBatokError = ''.obs;
  RxString jenisBriketError = ''.obs;
  RxString stokError = ''.obs;
  RxString keteranganError = ''.obs;

  late BriketArgument argument;

  @override
  void onInit() {
    dropdownSumberBatok(GlobalController.to.listSumberBatok);

    if (Get.arguments != null) {
      argument = Get.arguments as BriketArgument;
      if (argument.isEdit == true) {
        initEdit();
      }
    }

    super.onInit();
  }

  void validateForm() {
    bool isValid = true;

    if (jenisMasukanTxt.value.isEmpty) {
      jenisMasukanError.value = 'Tidak boleh kosong';
      isValid = false;
    } else {
      jenisMasukanError.value = '';
    }

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

    if (jenisBriketTxt.value.isEmpty) {
      jenisBriketError.value = 'Tidak boleh kosong';
      isValid = false;
    } else {
      jenisBriketError.value = '';
    }

    if (stokTxt.value.isEmpty) {
      stokError.value = 'Tidak boleh kosong';
      isValid = false;
    } else {
      stokError.value = '';
    }

    if (keteranganTxt.value.isEmpty) {
      keteranganError.value = 'Tidak boleh kosong';
      isValid = false;
    } else {
      keteranganError.value = '';
    }

    if (isValid) {
      postBriket();
    }
  }

  Future<void> postBriket() async {
    try {
      await GlobalController.to.checkConnection();

      if (GlobalController.to.isConnect.isTrue) {
        LoadingService.show();

        BriketPostResponseModel response = await BriketRepository.postBriket(
          jenisMasukan: jenisMasukanTxt.value,
          idBriket: idBriket.value == 0 ? null : idBriket.value,
          tanggal: tanggalTxt.value,
          sumberBatok: sumberBatokTxt.value,
          jenisBriket: jenisBriketTxt.value,
          stok: double.parse(stokTxt.value),
          keterangan: keteranganTxt.value,
        );

        if (response.status == 200) {
          LoadingService.dismiss();

          if (Get.isRegistered<BriketController>()) {
            var timer = Timer(const Duration(seconds: 3), () {
              Get.until((route) => Get.currentRoute == AppRoute.briketRoute);
              BriketController.to.getBriket();
            });

            DialogSuccess.show(
              status: isEdit.isTrue ? 'diedit' : 'ditambahkan',
              timer: timer,
              onPressed: () {
                timer.cancel();
                Get.until((route) => Get.currentRoute == AppRoute.briketRoute);
                BriketController.to.getBriket();
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
            errorMessage ?? 'Failed',
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
    idBriket.value = argument.listBriket?.id ?? 0;
    isEdit.value = argument.isEdit ?? false;
    jenisMasukanTxt.value = argument.listBriket?.jenisMasukan ?? '';
    tanggalTxt.value = argument.listBriket?.tanggal ?? '2024-01-01';
    tanggalTxtInit.value = GlobalController.to.formatDate(
      argument.listBriket?.tanggal ?? '2024-01-01',
    );
    sumberBatokTxt.value = argument.listBriket?.sumberBatok ?? '';
    jenisBriketTxt.value = argument.listBriket?.jenisBriket ?? '';
    selectedInputType.value = argument.listBriket?.jenisBriket ?? '';
    stokTxt.value = argument.listBriket?.stok.toString() ?? '';
    keteranganTxt.value = argument.listBriket?.keterangan ?? '';
  }
}
