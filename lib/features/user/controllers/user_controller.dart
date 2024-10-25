import 'dart:async';
import 'dart:developer';

import 'package:bas_app/configs/routes/app_route.dart';
import 'package:bas_app/features/user/models/user_fetch_model.dart';
import 'package:bas_app/features/user/repositories/user_repository.dart';
import 'package:bas_app/features/user_query/models/user_delete_response_model.dart';
import 'package:bas_app/features/user_query/repositories/user_query_repository.dart';
import 'package:bas_app/shared/controllers/global_controller.dart';
import 'package:bas_app/shared/widgets/general/dialog_success_widget.dart';
import 'package:bas_app/utils/services/loading_service.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  static UserController get to => Get.find();

  RxString selectedAdminMenu = ''.obs;
  RxList<UserData> userDataList = RxList([]);
  RxBool isEdit = false.obs;

  @override
  void onInit() {
    getAllUser();
    super.onInit();
  }

  Future<void> getAllUser() async {
    try {
      await GlobalController.to.checkConnection();
      if (GlobalController.to.isConnect.isTrue) {
        LoadingService.show();

        UserFetchResponseModel response = await UserRepository.getAllUser();

        if (response.status == 200) {
          userDataList.clear();
          userDataList.addAll(response.data ?? []);

          LoadingService.dismiss();
        }
      } else {
        LoadingService.dismiss();
        Get.toNamed(AppRoute.noConnectionRoute);
      }
    } on DioException catch (e) {
      log('ERROR GET USER : $e');
    }
  }

  Future<void> deleteUser({required int id}) async {
    try {
      await GlobalController.to.checkConnection();

      if (GlobalController.to.isConnect.isTrue) {
        LoadingService.show();

        UserDeleteResponseModel response =
            await UserQueryRepository.deleteUser(id: id);

        if (response.status == 200) {
          LoadingService.dismiss();

          var timer = Timer(const Duration(seconds: 3), () {
            Get.back();
            UserController.to.getAllUser();
          });

          DialogSuccess.show(
            status: 'dihapus',
            timer: timer,
            onPressed: () {
              timer.cancel();
              Get.back();
              UserController.to.getAllUser();
            },
          );
        }
      }
    } on DioException catch (e) {
      log(e.toString());
    } catch (e) {
      log(e.toString());
    }
  }
}
