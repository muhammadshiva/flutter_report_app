import 'dart:async';
import 'dart:developer';

import 'package:bas_app/configs/routes/app_route.dart';
import 'package:bas_app/features/user/controllers/user_controller.dart';
import 'package:bas_app/features/user_query/argument/user_query_argument.dart';
import 'package:bas_app/features/user_query/models/user_post_response_model.dart';
import 'package:bas_app/features/user_query/models/user_update_response_model.dart';
import 'package:bas_app/features/user_query/repositories/user_query_repository.dart';
import 'package:bas_app/shared/controllers/global_controller.dart';
import 'package:bas_app/shared/widgets/general/dialog_success_widget.dart';
import 'package:bas_app/utils/services/loading_service.dart';
import 'package:bcrypt/bcrypt.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class UserQueryController extends GetxController {
  static UserQueryController get to => Get.find();

  //* Position
  RxList<String> positionList =
      ['Kepala Produksi', 'Admin', 'Kepala Pabrik'].obs;

  //* Input String
  RxInt idUser = 0.obs;
  RxString nameTxt = ''.obs;
  RxString usernameTxt = ''.obs;
  RxString emailTxt = ''.obs;
  RxString phoneTxt = ''.obs;
  RxString pinTxt = ''.obs;
  RxString positionTxt = ''.obs;
  RxBool isEdit = false.obs;

  TextEditingController currentPassword = TextEditingController();
  RxBool isShowCurrentPassword = false.obs;
  RxString currentPasswordError = ''.obs;

  TextEditingController newPassword = TextEditingController();
  RxBool isShowNewPassword = false.obs;

  TextEditingController repeatPassword = TextEditingController();
  RxBool isShowRepeatPassword = false.obs;

  RxBool isValidPassword = false.obs;

  //* Error Input String
  RxString nameError = ''.obs;
  RxString usernameError = ''.obs;
  RxString emailError = ''.obs;
  RxString phoneError = ''.obs;
  RxString pinError = ''.obs;
  RxString positionError = ''.obs;

  late UserQueryArgument argument;

  //* Function for Image Picker
  final ImagePicker picker = ImagePicker();
  Rx<XFile?> selectedImage = Rx<XFile?>(null);

  @override
  void onInit() {
    if (Get.arguments != null) {
      argument = Get.arguments as UserQueryArgument;
      if (argument.isEdit == true) {
        initEdit();
      }
    }

    super.onInit();
  }

  void initEdit() {
    isEdit.value = argument.isEdit ?? false;
    idUser.value = argument.userData?.id ?? 0;
    nameTxt.value = argument.userData?.name ?? '';
    usernameTxt.value = argument.userData?.username ?? '';
    emailTxt.value = argument.userData?.email ?? '';
    phoneTxt.value = argument.userData?.phone ?? '';
    positionTxt.value = argument.userData?.position ?? '';

    print('NAME EDIT INIT : ${nameTxt.value}');
  }

  void checkPassword(String value) {
    String hashedPasswordFromBackend = argument.userData?.password ?? '';

    isValidPassword.value = BCrypt.checkpw(value, hashedPasswordFromBackend);

    if (isValidPassword.isTrue) {
      print('Valid Password');
    } else {
      currentPasswordError.value = '';
      print('Invalid Password');
    }
  }

  void validate() {
    bool isValid = true;

    if (nameTxt.value.isEmpty) {
      nameError.value = 'Nama tidak boleh kosong';
      isValid = false;
    } else {
      nameError.value = '';
    }

    if (usernameTxt.value.isEmpty) {
      usernameError.value = 'Username tidak boleh kosong';
      isValid = false;
    } else {
      usernameError.value = '';
    }

    if (emailTxt.value.isEmpty) {
      emailError.value = 'Email tidak boleh kosong';
      isValid = false;
    } else {
      emailError.value = '';
    }

    if (positionTxt.value.isEmpty) {
      positionError.value = 'Posisi tidak boleh kosong';
      isValid = false;
    } else {
      positionError.value = '';
    }

    if (currentPassword.text.isEmpty && isEdit.isFalse) {
      currentPasswordError.value = 'Password tidak boleh kosong';
      isValid = false;
    } else {
      currentPasswordError.value = '';
    }

    if (isValid) {
      if (isEdit.isTrue) {
        updateUser();
      } else {
        registerUser();
      }
    }
  }

  Future<void> registerUser() async {
    try {
      await GlobalController.to.checkConnection();

      if (GlobalController.to.isConnect.isTrue) {
        LoadingService.show();

        UserPostResponseModel response = await UserQueryRepository.registerUser(
          name: nameTxt.value,
          username: usernameTxt.value,
          email: emailTxt.value,
          position: positionTxt.value,
          password: currentPassword.text,
        );

        if (response.status == 200) {
          LoadingService.dismiss();

          if (Get.isRegistered<UserController>()) {
            var timer = Timer(const Duration(seconds: 3), () {
              Get.until((route) => Get.currentRoute == AppRoute.userRoute);
              UserController.to.getAllUser();
            });

            DialogSuccess.show(
              status: isEdit.isTrue ? 'diedit' : 'ditambahkan',
              timer: timer,
              onPressed: () {
                timer.cancel();
                Get.until((route) => Get.currentRoute == AppRoute.userRoute);
                UserController.to.getAllUser();
              },
            );
          }
        } else {
          String? errorMessage;
          if (response.message?.isNotEmpty == true) {
            errorMessage = response.message;
          }
          LoadingService.dismiss();

          Get.snackbar(
            'Failed',
            errorMessage ?? 'Create User Failed',
          );
        }
      } else {
        LoadingService.dismiss();
        Get.toNamed(AppRoute.noConnectionRoute);
      }
    } on DioException catch (e) {
      log(e.toString());
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> updateUser() async {
    try {
      await GlobalController.to.checkConnection();

      if (GlobalController.to.isConnect.isTrue) {
        LoadingService.show();

        UserUpdateResponseModel response = await UserQueryRepository.updateUser(
          id: idUser.value,
          name: nameTxt.value,
          username: usernameTxt.value,
          email: emailTxt.value,
          position: positionTxt.value,
          password: currentPassword.text,
        );

        print('NAME EDIT POST : ${nameTxt.value}');

        if (response.status == 200) {
          LoadingService.dismiss();

          if (Get.isRegistered<UserController>()) {
            var timer = Timer(const Duration(seconds: 3), () {
              Get.until((route) => Get.currentRoute == AppRoute.userRoute);
              UserController.to.getAllUser();
            });

            DialogSuccess.show(
              status: 'diedit',
              timer: timer,
              onPressed: () {
                timer.cancel();
                Get.until((route) => Get.currentRoute == AppRoute.userRoute);
                UserController.to.getAllUser();
              },
            );
          }
        } else {
          String? errorMessage;
          if (response.message?.isNotEmpty == true) {
            errorMessage = response.message;
          }
          LoadingService.dismiss();

          Get.snackbar(
            'Failed',
            errorMessage ?? 'Create User Failed',
          );
        }
      } else {
        LoadingService.dismiss();
        Get.toNamed(AppRoute.noConnectionRoute);
      }
    } on DioException catch (e) {
      log(e.toString());
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> pickImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage.value = image;
    }
  }

  Future<void> requestStoragePermission() async {
    if (await Permission.storage.request().isGranted) {
      // Permission granted, you can now access the gallery.
    } else {
      // Handle permission denied.
    }
  }
}
