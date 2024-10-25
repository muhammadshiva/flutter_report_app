import 'package:bas_app/features/admin/controllers/admin_controller.dart';
import 'package:get/get.dart';

class AdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AdminController());
  }
}
