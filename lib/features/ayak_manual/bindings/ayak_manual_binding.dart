import 'package:bas_app/features/ayak_manual/controllers/ayak_manual_controller.dart';
import 'package:get/get.dart';

class AyakManualBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AyakManualController());
  }
}
