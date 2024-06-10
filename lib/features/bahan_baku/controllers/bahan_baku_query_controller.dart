import 'dart:async';

import 'package:bas_app/configs/routes/app_route.dart';
import 'package:bas_app/features/bahan_baku/argument/bahan_baku_argument.dart';
import 'package:bas_app/features/bahan_baku/controllers/bahan_baku_controller.dart';
import 'package:bas_app/features/bahan_baku/models/bahan_baku_post_model.dart';
import 'package:bas_app/features/bahan_baku/repositories/bahan_baku_repository.dart';
import 'package:bas_app/shared/controllers/global_controller.dart';
import 'package:bas_app/shared/widgets/general/dialog_success_widget.dart';
import 'package:bas_app/utils/services/loading_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BahanBakuQueryController extends GetxController {
  static BahanBakuQueryController get to => Get.find();

  //* Main Value
  RxString selectedDropdown = ''.obs;
  RxBool isLoading = false.obs;
  RxBool isEdit = false.obs;
  RxList<String> dropdownSumberBatok = RxList([]);
  RxList<String> dropdownStokBahanBaku = ['Stok Arang', 'Stok Aci', 'Stok Cairan'].obs;
  RxInt idBahanBaku = 0.obs;

  //* Input String
  RxString jenisInputTxt = ''.obs;
  RxString tanggalTxt = ''.obs;
  RxString tanggalTxtInit = ''.obs;
  RxString sumberBatokTxt = ''.obs;
  RxString stokBahanBakuTxt = ''.obs;
  RxString jumlahBahanBakuTxt = ''.obs;
  RxString keteranganTxt = ''.obs;

  //* Error Input String
  RxString jenisInputError = ''.obs;
  RxString tanggalError = ''.obs;
  RxString sumberBatokError = ''.obs;
  RxString stokBahanBakuError = ''.obs;
  RxString jumlahBahanBakuError = ''.obs;
  RxString keteranganError = ''.obs;

  late BahanBakuArgument argument;

  @override
  void onInit() {
    dropdownSumberBatok(GlobalController.to.listSumberBatok);

    if (Get.arguments != null) {
      argument = Get.arguments as BahanBakuArgument;
      if (argument.isEdit == true) {
        initEdit();
      }
    }

    super.onInit();
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

    if (stokBahanBakuTxt.value.isEmpty) {
      stokBahanBakuError.value = 'Pilihan stok tidak boleh kosong';
      isValid = false;
    } else {
      stokBahanBakuError.value = '';
    }

    if (jumlahBahanBakuTxt.value.isEmpty) {
      jumlahBahanBakuError.value = 'Jumlah bahan baku tidak boleh kosong';
      isValid = false;
    } else {
      jumlahBahanBakuError.value = '';
    }

    if (keteranganTxt.value.isEmpty) {
      keteranganError.value = 'Keterangan tidak boleh kosong';
      isValid = false;
    } else {
      keteranganError.value = '';
    }

    if (isValid) {
      postBahanBaku();
    }
  }

  Future<void> postBahanBaku() async {
    try {
      await GlobalController.to.checkConnection();

      if (GlobalController.to.isConnect.isTrue) {
        LoadingService.show();

        BahanBakuPostResponseModel response = await BahanBakuRepository.postBahanBaku(
          idBahanBaku: idBahanBaku.value == 0 ? null : idBahanBaku.value,
          tanggal: tanggalTxt.value,
          jenisMasukan: jenisInputTxt.value,
          sumberBatok: sumberBatokTxt.value,
          bahanBaku: stokBahanBakuTxt.value,
          jumlahBahanBaku: double.parse(jumlahBahanBakuTxt.value),
          keterangan: keteranganTxt.value,
        );

        if (response.status == 200) {
          LoadingService.dismiss();

          if (Get.isRegistered<BahanBakuController>()) {
            var timer = Timer(const Duration(seconds: 3), () {
              Get.until((route) => Get.currentRoute == AppRoute.bahanBakuRoute);
              BahanBakuController.to.getBahanBaku();
            });

            DialogSuccess.show(
              status: isEdit.isTrue ? 'diedit' : 'ditambahkan',
              timer: timer,
              onPressed: () {
                timer.cancel();
                Get.until((route) => Get.currentRoute == AppRoute.bahanBakuRoute);
                BahanBakuController.to.getBahanBaku();
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
      debugPrint('$stackTrace');
      debugPrint('try $e');
    }
  }

  void initEdit() {
    isEdit.value = argument.isEdit ?? false;
    idBahanBaku.value = argument.listBahanBaku?.id ?? 0;
    jenisInputTxt.value = argument.listBahanBaku?.jenisMasukan ?? '';
    tanggalTxtInit.value = GlobalController.to.formatDate(
      argument.listBahanBaku?.tanggal ?? '2024-01-01',
    );
    tanggalTxt.value = argument.listBahanBaku?.tanggal ?? '2024-01-01';
    sumberBatokTxt.value = argument.listBahanBaku?.sumberBatok ?? '';
    stokBahanBakuTxt.value = argument.listBahanBaku?.bahanBaku ?? '';
    jumlahBahanBakuTxt.value = argument.listBahanBaku?.jumlah.toString() ?? '';
    keteranganTxt.value = argument.listBahanBaku?.keterangan ?? '';
  }

  void clearForm() {
    isEdit.value = false;
  }
}
