import 'package:flutter_report_app/features/production/controllers/production_controller.dart';
import 'package:get/get.dart';

class ProductionBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ProductionController());
  }
}
