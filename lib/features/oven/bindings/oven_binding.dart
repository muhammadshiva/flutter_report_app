import 'package:bas_app/features/oven/controllers/oven_controller.dart';
import 'package:get/get.dart';

class OvenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(OvenController());
  }
}
