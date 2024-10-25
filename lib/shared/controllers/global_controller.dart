import 'dart:developer';
import 'dart:io';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:restart_app/restart_app.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';

class GlobalController extends GetxController {
  static GlobalController get to => Get.find();

  var isConnect = false.obs;
  final _shorebirdCodePush = ShorebirdCodePush();

  RxBool isShorebirdAvailable = false.obs;
  RxInt? currentPatchVersion = 0.obs;
  RxBool isCheckingForUpdate = false.obs;

  RxString version = ''.obs;
  RxString platform = ''.obs;

  String currentVersionApp = '';
  RxBool hasUpdate = false.obs;
  RxBool isProgressUpdate = false.obs;
  RxBool updateSuccess = false.obs;

  Future<void> onUpdateApp() async {
    isProgressUpdate.value = true;
    await Future.wait([
      _shorebirdCodePush.downloadUpdateIfAvailable(),
      Future.delayed(const Duration(seconds: 2)),
    ]);
    isProgressUpdate.value = false;
    updateSuccess.value = true;
  }

  Future<RxBool> checkForUpdate() async {
    isCheckingForUpdate.value = true;
    await Future.delayed(const Duration(seconds: 2));

    final isUpdateAvailable =
        await _shorebirdCodePush.isNewPatchAvailableForDownload();
    isCheckingForUpdate.value = false;

    hasUpdate.value = isUpdateAvailable;

    log('Is Update Available: $isUpdateAvailable');

    return isUpdateAvailable.obs;
  }

  Future<String> getCurrentVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version.value = packageInfo.version;

    if (Platform.isAndroid) {
      platform.value = 'Android';
    }

    if (Platform.isIOS) {
      platform.value = 'iOS';
    }

    return '${packageInfo.version}+${packageInfo.buildNumber}';
  }

  Future<void> onRestartApp() async {
    Restart.restartApp();
  }

  Future<void> checkConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isConnect.value = true;
      }
    } on SocketException catch (_) {
      isConnect.value = false;
    }
  }

  String formatDate(String date) {
    DateTime dateTime = DateTime.parse(date);
    // Create a DateFormat instance with the desired format
    DateFormat dateFormat = DateFormat("d MMMM yyyy", "id_ID");
    return dateFormat.format(dateTime);
  }

  String convertDate(String date) {
    // Create a DateFormat instance for the input format
    DateFormat inputFormat = DateFormat("d MMMM yyyy", "id_ID");
    // Parse the input date string to DateTime
    DateTime dateTime = inputFormat.parse(date);

    // Create a DateFormat instance for the output format
    DateFormat outputFormat = DateFormat("yyyy-MM-dd");
    // Format the DateTime to the desired output format
    return outputFormat.format(dateTime);
  }

  @override
  void onInit() {
    isShorebirdAvailable.value = _shorebirdCodePush.isShorebirdAvailable();

    _shorebirdCodePush
        .currentPatchNumber()
        .then((value) => currentPatchVersion!.value = value ?? 0);

    getCurrentVersion().then((value) => currentVersionApp = value);
    super.onInit();
  }
}
