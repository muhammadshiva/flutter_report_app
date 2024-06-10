import 'package:bas_app/features/ayak_manual/controllers/ayak_manual_query_controller.dart';
import 'package:get/get.dart';

class AyakManualQueryBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AyakManualQueryController());
  }
}
