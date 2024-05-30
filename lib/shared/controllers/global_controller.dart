import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class GlobalController extends GetxController {
  static GlobalController get to => Get.find();

  var isConnect = false.obs;

  Future<void> checkConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isConnect.value = true;
      }
    } on SocketException catch (_) {
      isConnect.value = false;
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
      // tanggal.text = DateFormat('dd MMMM yyyy', 'id_ID').format(pickedDate);
      // postTanggal.value = DateFormat('yyyy-MM-dd').format(pickedDate);
      // tanggalErrorText.value = '';
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
