import 'dart:io';
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

  String formatDate(String date) {
    DateTime dateTime = DateTime.parse(date);
    // Create a DateFormat instance with the desired format
    DateFormat dateFormat = DateFormat("d MMMM yyyy", "id_ID");
    return dateFormat.format(dateTime);
  }

  String convertDate(String date) {
    // Create a DateFormat instance for the input format
    DateFormat inputFormat = DateFormat("d MMMM yyyy", "id_ID");
    // Parse the input date string to DateTime
    DateTime dateTime = inputFormat.parse(date);

    // Create a DateFormat instance for the output format
    DateFormat outputFormat = DateFormat("yyyy-MM-dd");
    // Format the DateTime to the desired output format
    return outputFormat.format(dateTime);
  }

  @override
  void onInit() {
    super.onInit();
  }
}
