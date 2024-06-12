import 'package:bas_app/features/briket/controllers/briket_query_controller.dart';
import 'package:get/get.dart';

class BriketQueryBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BriketQueryController());
  }
}
