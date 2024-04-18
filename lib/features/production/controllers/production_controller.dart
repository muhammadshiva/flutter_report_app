import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ProductionController extends GetxController {
  static ProductionController get to => Get.find();

  var idMenu = 0.obs;
  var titleMenu = ''.obs;
  var tabIndex = 1.obs;
  var homeTabIndex = 1.obs;

  TextEditingController dateController = TextEditingController(text: '');

  List<Map<String, dynamic>> tabData = [
    {"id": 1, "tabName": "Mingguan"},
    {"id": 2, "tabName": "Bulanan"},
    {"id": 3, "tabName": "Tahunan"}
  ];

  @override
  void onInit() {
    idMenu.value = Get.arguments['id'];
    titleMenu.value = Get.arguments['title'];
    homeTabIndex.value = Get.arguments['tabIndex'];
    super.onInit();
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      dateController.text = DateFormat('dd MMMM yyyy').format(pickedDate);
    }
  }
}
