import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_report_app/configs/routes/route.dart';
import 'package:flutter_report_app/features/batok/models/batok_model.dart';
import 'package:flutter_report_app/features/batok/models/batok_post_model.dart';
import 'package:flutter_report_app/features/batok/repository/batok_repository.dart';
import 'package:flutter_report_app/shared/controllers/global_controller.dart';
import 'package:flutter_report_app/shared/styles/color_style.dart';
import 'package:flutter_report_app/shared/styles/google_text_style.dart';
import 'package:flutter_report_app/shared/widgets/elevated_button_timer_widget.dart';
import 'package:flutter_report_app/utils/services/loading_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class BatokController extends GetxController {
  static BatokController get to => Get.find();

  RxInt idMenu = 0.obs;
  RxInt idBatok = 0.obs;
  RxBool isEdit = false.obs;
  RxBool isScroll = false.obs;
  RxInt tabIndex = 1.obs;
  RxString titleMenu = ''.obs;
  RxInt homeTabIndex = 1.obs;
  RxBool isLoading = false.obs;

  ListBatok batokData = ListBatok();

  TextEditingController tanggal = TextEditingController(text: '');
  RxString postTanggal = ''.obs;
  RxString tanggalErrorText = ''.obs;

  TextEditingController keterangan = TextEditingController(text: '');
  RxString keteranganErrorText = ''.obs;

  RxString sumberBatok = ''.obs;
  RxString sumberBatokErrorText = ''.obs;

  TextEditingController barangKeluar = TextEditingController(text: '');
  RxString barangKeluarErrorText = ''.obs;

  TextEditingController barangMasuk = TextEditingController(text: '');
  RxString barangMasukErrorText = ''.obs;

  TextEditingController stokAwal = TextEditingController(text: '');
  RxString stokAwalErrorText = ''.obs;

  TextEditingController stokAkhir = TextEditingController(text: '');
  RxString stokAkhirErrorText = ''.obs;

  RxList<String> listSumberBatok = ['Kalimantan', 'Sumatera', 'Sulawesi'].obs;

  RxList<BatokData> listBatokData = RxList([]);

  List<Map<String, dynamic>> tabData = [
    {"id": 1, "tabName": "Mingguan"},
    {"id": 2, "tabName": "Bulanan"},
    {"id": 3, "tabName": "Tahunan"}
  ];

  @override
  void onInit() {
    if (Get.arguments != null) {
      idMenu.value = Get.arguments['id'];
      titleMenu.value = Get.arguments['title'];
      homeTabIndex.value = Get.arguments['tabIndex'];
    }

    getBatok();
    super.onInit();
  }

  Future<void> getBatok() async {
    try {
      await GlobalController.to.checkConnection();
      if (GlobalController.to.isConnect.isTrue) {
        LoadingService.show();
        isLoading.value = true;

        BatokResponseModel response = await BatokRepository.getBatok();

        if (response.status == 200) {
          listBatokData(response.data);
          LoadingService.dismiss();
          isLoading.value = false;
        }
      } else {
        LoadingService.dismiss();
        isLoading.value = false;
        Get.toNamed(Routes.noConnectionRoute);
      }
    } on DioException catch (e) {
      log('ERROR : $e');
    }
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          datePickerTheme: const DatePickerThemeData(
            surfaceTintColor: Colors.white,
          ),
          colorScheme: const ColorScheme.light(
            primary: Colors.blue,
            onPrimary: Colors.white,
            onSurface: Colors.black,
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              primary: Colors.black,
            ),
          ),
        ),
        child: child!,
      ),
    );

    if (pickedDate != null) {
      tanggal.text = DateFormat('dd MMMM yyyy', 'id_ID').format(pickedDate);
      postTanggal.value = DateFormat('yyyy-MM-dd').format(pickedDate);
      tanggalErrorText.value = '';
    }
  }

  String formatDate({required String date}) {
    String dateString = date;
    DateTime dateTime = DateTime.parse(dateString);
    String formattedDate = DateFormat("d MMMM yyyy", 'id_ID').format(dateTime);
    return formattedDate;
  }

  String formatPostDate({required String date}) {
    String dateString = date;
    DateTime dateTime = DateTime.parse(dateString);
    String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
    return formattedDate;
  }

  Future<void> postBatok() async {
    try {
      await GlobalController.to.checkConnection();

      if (tanggal.text.isEmpty) tanggalErrorText.value = 'Tidak boleh kosong';
      if (sumberBatok.value.isEmpty) sumberBatokErrorText.value = 'Tidak boleh kosong';
      if (barangKeluar.text.isEmpty) barangKeluarErrorText.value = 'Tidak boleh kosong';
      if (barangMasuk.text.isEmpty) barangMasukErrorText.value = 'Tidak boleh kosong';
      if (stokAwal.text.isEmpty) stokAwalErrorText.value = 'Tidak boleh kosong';
      if (stokAkhir.text.isEmpty) stokAkhirErrorText.value = 'Tidak boleh kosong';
      if (keterangan.text.isEmpty) keteranganErrorText.value = 'Tidak boleh kosong';

      var isValid = tanggalErrorText.value.isEmpty &&
          sumberBatokErrorText.value.isEmpty &&
          barangKeluarErrorText.value.isEmpty &&
          barangMasukErrorText.value.isEmpty &&
          stokAwalErrorText.value.isEmpty &&
          stokAkhirErrorText.value.isEmpty &&
          keteranganErrorText.value.isEmpty;

      if (isValid && GlobalController.to.isConnect.isTrue) {
        LoadingService.show();

        debugPrint('ID BATOK : ${idBatok.value}');
        BatokPostResponseModel response = await BatokRepository.postBatok(
          idBatok: idBatok.value == 0 ? null : idBatok.value,
          tanggal: postTanggal.value,
          sumberBatok: sumberBatok.value,
          barangMasuk: double.parse(barangMasuk.text),
          barangKeluar: double.parse(barangKeluar.text),
          stokAwal: double.parse(stokAwal.text),
          stokAkhir: double.parse(stokAkhir.text),
          keterangan: keterangan.text,
        );

        if (response.status == 200) {
          LoadingService.dismiss();

          var timer = Timer(const Duration(seconds: 3), () {
            Get.until((route) => Get.currentRoute == Routes.batokRoute);
            getBatok();
          });

          showDialog(
            barrierDismissible: false,
            context: Get.context!,
            builder: (context) {
              return AlertDialog(
                title: Column(
                  children: [
                    Icon(
                      Icons.check_circle,
                      size: 60.w,
                      color: ColorStyle.green,
                    ),
                    SizedBox(height: 10.w),
                    Text(
                      'Sukses',
                      style: GoogleFonts.roboto().copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 18.sp,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 5.w),
                    Text(
                      'Data berhasil ${isEdit.isFalse ? 'ditambahkan' : 'diedit'}',
                      style: GoogleFonts.roboto().copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
                actions: [
                  ElevatedButtonTimerWidget(
                    width: double.infinity,
                    text: 'OK',
                    color: Colors.green,
                    textStyle: whiteTextStyle.copyWith(fontSize: 14.sp),
                    onPressed: () {
                      timer.cancel();
                      Get.until((route) => Get.currentRoute == Routes.batokRoute);
                      getBatok();
                    },
                  ),
                ],
              );
            },
          );
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
        Get.toNamed(Routes.noConnectionRoute);
      }
    } on DioException catch (e, stackTrace) {
      debugPrint('$stackTrace');
      log('try $e');
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

        if (response.message == 'Data Batok berhasil dihapus') {
          LoadingService.dismiss();

          var timer = Timer(const Duration(seconds: 3), () {
            Get.until((route) => Get.currentRoute == Routes.batokRoute);
            getBatok();
          });

          showDialog(
            barrierDismissible: false,
            context: Get.context!,
            builder: (context) {
              return AlertDialog(
                title: Column(
                  children: [
                    Icon(
                      Icons.check_circle,
                      size: 60.w,
                      color: ColorStyle.green,
                    ),
                    SizedBox(height: 10.w),
                    Text(
                      'Sukses',
                      style: GoogleFonts.roboto().copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 18.sp,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 5.w),
                    Text(
                      'Data berhasil dihapus',
                      style: GoogleFonts.roboto().copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
                actions: [
                  ElevatedButtonTimerWidget(
                    width: double.infinity,
                    text: 'OK',
                    color: Colors.green,
                    textStyle: whiteTextStyle.copyWith(fontSize: 14.sp),
                    onPressed: () {
                      timer.cancel();
                      Get.until((route) => Get.currentRoute == Routes.batokRoute);
                      getBatok();
                    },
                  ),
                ],
              );
            },
          );
        }
      } else if (GlobalController.to.isConnect.value == false) {
        LoadingService.dismiss();
        Get.toNamed(Routes.noConnectionRoute);
      }
    } on DioException catch (e, stackTrace) {
      debugPrint('$stackTrace');
      log('try $e');
    }
  }
}
