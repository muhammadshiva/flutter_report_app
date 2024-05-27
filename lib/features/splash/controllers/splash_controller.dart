import 'dart:async';

import 'package:flutter_report_app/configs/routes/route.dart';
import 'package:flutter_report_app/utils/services/hive_service.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  static SplashController get to => Get.find();

  @override
  void onReady() {
    loading();
    super.onReady();
  }

  Future<void> loading() async {
    var isLogin = HiveService.box.get('isLogin') ?? false;

    if (isLogin) {
      Timer(const Duration(seconds: 2), () {
        Get.offAllNamed(Routes.homeRoute);
      });
      return;
    }

    Timer(const Duration(seconds: 2), () {
      Get.offNamed(Routes.signInRoute);
    });
  }
}
