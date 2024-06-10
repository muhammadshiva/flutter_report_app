import 'dart:async';

import 'package:bas_app/configs/routes/app_route.dart';
import 'package:bas_app/utils/services/hive_service.dart';
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
        Get.offAllNamed(AppRoute.homeRoute);
      });
      return;
    }

    Timer(const Duration(seconds: 2), () {
      Get.offNamed(AppRoute.signInRoute);
    });
  }
}
