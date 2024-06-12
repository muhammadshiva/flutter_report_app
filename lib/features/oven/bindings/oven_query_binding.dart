import 'package:bas_app/features/oven/controllers/oven_query_controller.dart';
import 'package:get/get.dart';

class OvenQueryBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(OvenQueryController());
  }
}
