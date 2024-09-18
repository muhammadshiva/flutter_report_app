import 'dart:async';
import 'dart:developer';

import 'package:bas_app/configs/routes/app_route.dart';
import 'package:bas_app/features/home/controller/home_controller.dart';
import 'package:bas_app/features/oven/argument/oven_argument.dart';
import 'package:bas_app/features/oven/controllers/oven_controller.dart';
import 'package:bas_app/features/oven/models/oven_post_model.dart';
import 'package:bas_app/features/oven/repositories/oven_repository.dart';
import 'package:bas_app/shared/controllers/global_controller.dart';
import 'package:bas_app/shared/widgets/general/dialog_success_widget.dart';
import 'package:bas_app/utils/services/loading_service.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class OvenQueryController extends GetxController {
  static OvenQueryController get to => Get.find();

  //* Main Value
  RxString selectedDropdown = ''.obs;
  RxBool isLoading = false.obs;
  RxBool isEdit = false.obs;
  RxList<String> dropdownSumberBatok = RxList([]);
  RxList<String> grades = ['Grade A', 'Grade B', 'Grade C'].obs;
  RxString selectedInputType = ''.obs;
  RxInt idOven = 0.obs;

  //* SAMPEL DATA
  //   {
  //     "jenis_masukan": "Penambahan",
  //     "tanggal" : "2024-05-09",
  //     "sumber_batok" : "Sumatera",
  //     "jenis_briket" : "Grade B",
  //     "pengovenan" : 1100.0,
  //     "pendinginan" : 1200.0,
  //     "keterangan" : "Tidak ada"
  // }

  //* Input String
  RxString jenisMasukanTxt = ''.obs;
  RxString tanggalTxt = ''.obs;
  RxString tanggalTxtInit = ''.obs;
  RxString sumberBatokTxt = ''.obs;
  RxString jenisBriketTxt = ''.obs;
  RxString pengovenanTxt = ''.obs;
  RxString pendinginanTxt = ''.obs;
  RxString keteranganTxt = ''.obs;

  //* Error Input String
  RxString jenisMasukanError = ''.obs;
  RxString tanggalError = ''.obs;
  RxString sumberBatokError = ''.obs;
  RxString jenisBriketError = ''.obs;
  RxString pengovenanError = ''.obs;
  RxString pendinginanError = ''.obs;
  RxString keteranganError = ''.obs;

  late OvenArgument argument;
  @override
  void onInit() {
    dropdownSumberBatok(HomeController.to.listSumberBatok);

    if (Get.arguments != null) {
      argument = Get.arguments as OvenArgument;
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

    if (pengovenanTxt.value.isEmpty) {
      pengovenanError.value = 'Tidak boleh kosong';
      isValid = false;
    } else {
      pengovenanError.value = '';
    }

    if (pendinginanTxt.value.isEmpty) {
      pendinginanError.value = 'Tidak boleh kosong';
      isValid = false;
    } else {
      pendinginanError.value = '';
    }

    if (keteranganTxt.value.isEmpty) {
      keteranganError.value = 'Tidak boleh kosong';
      isValid = false;
    } else {
      keteranganError.value = '';
    }

    if (isValid) {
      postOven();
    }
  }

  Future<void> postOven() async {
    try {
      await GlobalController.to.checkConnection();

      if (GlobalController.to.isConnect.isTrue) {
        LoadingService.show();

        OvenPostResponseModel response = await OvenRepository.postOven(
          jenisMasukan: jenisMasukanTxt.value,
          idOven: idOven.value == 0 ? null : idOven.value,
          tanggal: tanggalTxt.value,
          sumberBatok: sumberBatokTxt.value,
          jenisBriket: jenisBriketTxt.value,
          pengovenan: double.parse(pengovenanTxt.value),
          pendinginan: double.parse(pendinginanTxt.value),
          keterangan: keteranganTxt.value,
        );

        if (response.status == 200) {
          LoadingService.dismiss();

          if (Get.isRegistered<OvenController>()) {
            var timer = Timer(const Duration(seconds: 3), () {
              Get.until((route) => Get.currentRoute == AppRoute.ovenRoute);
              OvenController.to.getOven();
            });

            DialogSuccess.show(
              status: isEdit.isTrue ? 'diedit' : 'ditambahkan',
              timer: timer,
              onPressed: () {
                timer.cancel();
                Get.until((route) => Get.currentRoute == AppRoute.ovenRoute);
                OvenController.to.getOven();
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
    idOven.value = argument.listOven?.id ?? 0;
    isEdit.value = argument.isEdit ?? false;
    jenisMasukanTxt.value = argument.listOven?.jenisMasukan ?? '';
    tanggalTxt.value = argument.listOven?.tanggal ?? '2024-01-01';
    tanggalTxtInit.value = GlobalController.to.formatDate(
      argument.listOven?.tanggal ?? '2024-01-01',
    );
    sumberBatokTxt.value = argument.listOven?.sumberBatok ?? '';
    jenisBriketTxt.value = argument.listOven?.jenisBriket ?? '';
    selectedInputType.value = argument.listOven?.jenisBriket ?? '';
    pengovenanTxt.value = argument.listOven?.pengovenan.toString() ?? '';
    pendinginanTxt.value = argument.listOven?.pendinginan.toString() ?? '';
    keteranganTxt.value = argument.listOven?.keterangan ?? '';
  }
}
