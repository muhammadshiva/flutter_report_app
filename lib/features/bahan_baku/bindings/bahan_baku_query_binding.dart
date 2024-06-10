import 'package:bas_app/features/bahan_baku/controllers/bahan_baku_query_controller.dart';
import 'package:get/get.dart';

class BahanBakuQueryBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BahanBakuQueryController());
  }
}
