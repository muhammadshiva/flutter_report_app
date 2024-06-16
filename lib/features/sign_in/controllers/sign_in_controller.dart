import 'dart:async';
import 'dart:developer';

import 'package:bas_app/configs/routes/app_route.dart';
import 'package:bas_app/features/sign_in/models/sign_in_model.dart';
import 'package:bas_app/features/sign_in/repositories/sign_in_repository.dart';
import 'package:bas_app/shared/controllers/global_controller.dart';
import 'package:bas_app/utils/services/hive_service.dart';
import 'package:bas_app/utils/services/loading_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class SignInController extends GetxController {
  static SignInController get to => Get.find();

  final formKey = GlobalKey<FormState>();

  var isShowPassword = false.obs;
  var passwordCtrl = TextEditingController();
  var emailCtrl = TextEditingController();
  var passwordErrorText = "".obs;
  var emailErrorText = "".obs;
  var isDisable = false.obs;

  @override
  void onInit() {
    emailCtrl.addListener(onChangeEmail);
    passwordCtrl.addListener(onChangePassword);
    super.onInit();
  }

  void validateForm(context) async {
    try {
      await GlobalController.to.checkConnection();

      if (emailCtrl.text.isEmpty || passwordCtrl.text.isEmpty) {
        if (emailCtrl.text.isEmpty) {
          emailErrorText.value = 'Email tidak boleh kosong';
        }

        if (passwordCtrl.text.isEmpty) {
          passwordErrorText.value = 'Password tidak boleh kosong';
        }
        return;
      }

      var isValid = emailErrorText.isEmpty && passwordErrorText.isEmpty;
      Get.focusScope!.unfocus();

      if (isValid && GlobalController.to.isConnect.isTrue) {
        LoadingService.show();
        isDisable.value = true;
        formKey.currentState!.save();

        SignInResponseModel response = await SignInRepository.signIn(
          email: emailCtrl.text,
          password: passwordCtrl.text,
        );

        if (response.status == 200) {
          await HiveService.setAuth(response.data!, isLogin: true);
          Get.offAllNamed(AppRoute.homeRoute);
        } else {
          LoadingService.dismiss();
          Get.snackbar(
            'Peringatan'.tr,
            response.message ?? 'Terjadi masalah pada server',
            backgroundColor: Colors.red.shade300,
            colorText: Colors.white,
            duration: const Duration(seconds: 2),
          );
          Timer(const Duration(seconds: 3), () {
            isDisable.value = false;
          });
        }

        LoadingService.dismiss();
      } else {
        Get.toNamed(AppRoute.noConnectionRoute);
      }
    } on DioException catch (e) {
      log('ERROR SIGN IN : $e');
    }
  }

  void onChangeEmail() {
    final email = emailCtrl.text;
    if (email.isEmpty) {
      emailErrorText.value = "Email tidak boleh kosong";
    } else if (!isValidEmail(email)) {
      emailErrorText.value = "Email harus sesuai format";
    } else {
      emailErrorText.value = "";
    }
  }

  void onChangePassword() {
    final password = passwordCtrl.text;
    if (password.isEmpty) {
      passwordErrorText.value = "Password tidak boleh kosong";
    } else if (password.length < 6) {
      passwordErrorText.value = "Password minimal 6 karakter";
    } else {
      passwordErrorText.value = "";
    }
  }

  bool isValidEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  bool isValidPassword(String password) {
    String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(password);
  }
}
