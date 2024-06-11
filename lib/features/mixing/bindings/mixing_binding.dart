import 'package:bas_app/features/mixing/controllers/mixing_controller.dart';
import 'package:get/get.dart';

class MixingBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MixingController());
  }
}
