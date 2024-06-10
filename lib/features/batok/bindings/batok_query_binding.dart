import 'package:bas_app/features/batok/controllers/batok_query_controller.dart';
import 'package:get/get.dart';

class BatokQueryBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BatokQueryController());
  }
}
