import 'package:bas_app/features/ayak_rotari/controllers/ayak_rotari_query_controller.dart';
import 'package:get/get.dart';

class AyakRotariQueryBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AyakRotariQueryController());
  }
}
