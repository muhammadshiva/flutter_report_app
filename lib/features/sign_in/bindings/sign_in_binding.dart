import 'package:flutter_report_app/features/sign_in/controllers/sign_in_controller.dart';
import 'package:get/get.dart';

class SingInBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignInController());
  }
}
