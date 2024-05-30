import 'package:get/get.dart';

class AyakManualController extends GetxController {
  static AyakManualController get to => Get.find();

  RxInt tabIndex = 1.obs;
  RxString filterBy = 'Mingguan'.obs;
}
