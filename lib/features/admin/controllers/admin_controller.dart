import 'package:bas_app/configs/routes/app_route.dart';
import 'package:bas_app/utils/services/hive_service.dart';
import 'package:get/get.dart';

class AdminController extends GetxController {
  static AdminController get to => Get.find();

  RxString selectedAdminMenu = ''.obs;

  void logout() async {
    await HiveService.deleteAuth();
    Get.offAllNamed(AppRoute.signInRoute);
  }
}
