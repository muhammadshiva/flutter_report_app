import 'package:bas_app/features/ayak_rotari/controllers/ayak_rotari_controller.dart';
import 'package:get/get.dart';

class AyakRotariBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AyakRotariController());
  }
}
