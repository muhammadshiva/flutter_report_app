import 'package:bas_app/features/diskmill/controllers/diskmill_query_controller.dart';
import 'package:get/get.dart';

class DiskmillQueryBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DiskmillQueryController());
  }
}
