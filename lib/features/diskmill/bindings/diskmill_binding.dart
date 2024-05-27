import 'package:flutter_report_app/features/diskmill/controllers/diskmill_controller.dart';
import 'package:get/get.dart';

class DiskmillBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DiskmillController());
  }
}
