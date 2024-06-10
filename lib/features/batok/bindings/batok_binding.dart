import 'package:bas_app/features/batok/controllers/batok_controller.dart';
import 'package:get/get.dart';

class BatokBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BatokController());
  }
}
