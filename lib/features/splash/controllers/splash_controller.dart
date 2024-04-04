import 'dart:async';

import 'package:flutter_report_app/configs/routes/route.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  static SplashController get to => Get.find();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    // Timer(const Duration(seconds: 2), () {
    //   Get.offAllNamed(Routes.signInRoute);
    // });
    super.onReady();
  }
}
