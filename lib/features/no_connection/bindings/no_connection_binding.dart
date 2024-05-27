import 'package:flutter_report_app/features/no_connection/controllers/no_connection_controller.dart';
import 'package:get/get.dart';

class NoConnectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NoConnectionController());
  }
}
