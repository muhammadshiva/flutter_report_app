import 'package:bas_app/features/mixing/controllers/mixing_query_controller.dart';
import 'package:get/get.dart';

class MixingQueryBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MixingQueryController());
  }
}
