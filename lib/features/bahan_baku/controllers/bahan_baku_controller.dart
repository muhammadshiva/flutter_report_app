import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_report_app/configs/routes/route.dart';
import 'package:flutter_report_app/features/bahan_baku/models/bahan_baku_model.dart';
import 'package:flutter_report_app/features/bahan_baku/models/bahan_baku_post_model.dart';
import 'package:flutter_report_app/features/bahan_baku/repository/bahan_baku_repository.dart';
import 'package:flutter_report_app/shared/controllers/global_controller.dart';
import 'package:flutter_report_app/shared/styles/color_style.dart';
import 'package:flutter_report_app/shared/styles/google_text_style.dart';
import 'package:flutter_report_app/shared/widgets/button/button_timer_widget_custom.dart';
import 'package:flutter_report_app/utils/services/loading_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class BahanBakuController extends GetxController {
  static BahanBakuController get to => Get.find();

  RxInt idMenu = 0.obs;
  RxInt idBahanBaku = 0.obs;
  RxString titleMenu = ''.obs;
  RxInt tabIndex = 1.obs;
  RxInt homeTabIndex = 1.obs;
  RxBool isEdit = false.obs;
  RxBool isLoading = false.obs;
  RxBool isScroll = false.obs;

  List<Map<String, dynamic>> tabData = [
    {"id": 1, "tabName": "Mingguan"},
    {"id": 2, "tabName": "Bulanan"},
    {"id": 3, "tabName": "Tahunan"}
  ];

  TextEditingController tanggal = TextEditingController(text: '');
  RxString postTanggal = ''.obs;
  RxString tanggalErrorText = ''.obs;

  RxList<BahanBakuData> listBahanBakuData = RxList([]);

  TextEditingController jumlahMasuk = TextEditingController(text: '');
  RxString jumlahMasukErrorText = ''.obs;

  TextEditingController jumlahKeluar = TextEditingController(text: '');
  RxString jumlahKeluarErrorText = ''.obs;

  RxList<String> listSumberBatok = ['Kalimantan', 'Sumatera', 'Sulawesi'].obs;
  RxString sumberBatok = ''.obs;
  RxString sumberBatokErrorText = ''.obs;

  RxList<String> listBahanBaku = ['Stok Arang', 'Stok Aci', 'Stok Cairan'].obs;
  RxString bahanBaku = ''.obs;
  RxString bahanBakuErrorText = ''.obs;

  TextEditingController keterangan = TextEditingController(text: '');
  RxString keteranganErrorText = ''.obs;

  @override
  void onInit() {
    idMenu.value = Get.arguments['id'];
    titleMenu.value = Get.arguments['title'];
    homeTabIndex.value = Get.arguments['tabIndex'];

    getBahanBaku();
    super.onInit();
  }

  Future<void> getBahanBaku() async {
    try {
      await GlobalController.to.checkConnection();
      if (GlobalController.to.isConnect.isTrue) {
        LoadingService.show();
        isLoading.value = true;

        BahanBakuResponseModel response = await BahanBakuRepository.getBahanBaku();

        if (response.status == 200) {
          listBahanBakuData(response.data);
          LoadingService.dismiss();
          isLoading.value = false;
        }
      } else {
        LoadingService.dismiss();
        isLoading.value = false;

        Get.toNamed(Routes.noConnectionRoute);
      }
    } on DioException catch (e) {
      log("ERROR : $e");
    }
  }

  Future<void> postBahanBaku() async {
    try {
      await GlobalController.to.checkConnection();

      if (tanggal.text.isEmpty) tanggalErrorText.value = 'Tidak boleh kosong';
      if (sumberBatok.value.isEmpty) sumberBatokErrorText.value = 'Tidak boleh kosong';
      if (jumlahMasuk.text.isEmpty) jumlahMasukErrorText.value = 'Tidak boleh kosong';
      if (jumlahKeluar.text.isEmpty) jumlahKeluarErrorText.value = 'Tidak boleh kosong';
      if (keterangan.text.isEmpty) keteranganErrorText.value = 'Tidak boleh kosong';

      var isValid = tanggalErrorText.value.isEmpty &&
          sumberBatokErrorText.value.isEmpty &&
          jumlahMasukErrorText.value.isEmpty &&
          jumlahKeluarErrorText.value.isEmpty &&
          keteranganErrorText.value.isEmpty;

      if (isValid && GlobalController.to.isConnect.isTrue) {
        LoadingService.show();

        BahanBakuPostResponseModel response = await BahanBakuRepository.postBahanBaku(
          idBahanBaku: idBahanBaku.value == 0 ? null : idBahanBaku.value,
          tanggal: postTanggal.value,
          sumberBatok: sumberBatok.value,
          bahanBaku: bahanBaku.value,
          jumlahMasuk: double.parse(jumlahMasuk.text),
          jumlahKeluar: double.parse(jumlahKeluar.text),
          keterangan: keterangan.text,
        );

        if (response.status == 200) {
          LoadingService.dismiss();

          var timer = Timer(const Duration(seconds: 3), () {
            Get.until((route) => Get.currentRoute == Routes.bahanBakuRoute);
            getBahanBaku();
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
                  ButtonTimerWidgetCustom(
                    width: double.infinity,
                    text: 'OK',
                    color: Colors.green,
                    textStyle: whiteTextStyle.copyWith(fontSize: 14.sp),
                    onPressed: () {
                      timer.cancel();
                      Get.until((route) => Get.currentRoute == Routes.bahanBakuRoute);
                      getBahanBaku();
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

  Future<void> deleteBahanBaku({required int idBahanBaku}) async {
    try {
      await GlobalController.to.checkConnection();
      LoadingService.show();

      if (GlobalController.to.isConnect.isTrue) {
        DeleteBahanBakuResponseModel response = await BahanBakuRepository.deleteBahanBaku(
          idBahanBaku: idBahanBaku,
        );

        if (response.message == 'Data deleted successfully') {
          LoadingService.dismiss();

          var timer = Timer(const Duration(seconds: 3), () {
            Get.until((route) => Get.currentRoute == Routes.bahanBakuRoute);
            getBahanBaku();
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
                  ButtonTimerWidgetCustom(
                    width: double.infinity,
                    text: 'OK',
                    color: Colors.green,
                    textStyle: whiteTextStyle.copyWith(fontSize: 14.sp),
                    onPressed: () {
                      timer.cancel();
                      Get.until((route) => Get.currentRoute == Routes.bahanBakuRoute);
                      getBahanBaku();
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
              backgroundColor: Colors.black,
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
}
