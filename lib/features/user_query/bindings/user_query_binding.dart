import 'package:bas_app/features/user_query/controllers/user_query_controller.dart';
import 'package:get/get.dart';

class UserQueryBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(UserQueryController());
  }
}
