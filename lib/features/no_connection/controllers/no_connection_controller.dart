import 'package:bas_app/shared/controllers/global_controller.dart';
import 'package:bas_app/utils/services/loading_service.dart';
import 'package:get/get.dart';

class NoConnectionController extends GetxController {
  static NoConnectionController get to => Get.find();

  void checkConnection(context) async {
    LoadingService.show();

    await GlobalController.to.checkConnection();

    if (GlobalController.to.isConnect.isTrue) {
      LoadingService.dismiss();
      Get.back();
    } else {
      LoadingService.dismiss();
      Get.snackbar('Gagal', 'Perangkat anda tidak terhubung ke koneksi internet');
    }
  }
}
