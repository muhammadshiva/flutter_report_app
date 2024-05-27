import 'package:flutter_report_app/features/ayak_manual/controllers/ayak_maual_controller.dart';
import 'package:get/get.dart';

class AyakManualBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AyakManualController());
  }
}
