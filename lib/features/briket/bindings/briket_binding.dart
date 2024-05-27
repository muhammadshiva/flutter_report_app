import 'package:flutter_report_app/features/briket/controllers/briket_controller.dart';
import 'package:get/get.dart';

class BriketBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BriketController());
  }
}
