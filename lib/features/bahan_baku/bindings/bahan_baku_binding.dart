import 'package:flutter_report_app/features/bahan_baku/controllers/bahan_baku_controller.dart';
import 'package:get/get.dart';

class BahanBakuBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BahanBakuController());
  }
}
