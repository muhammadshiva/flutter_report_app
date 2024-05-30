import 'package:flutter/material.dart';
import 'package:flutter_report_app/configs/routes/route.dart';
import 'package:flutter_report_app/constants/global_asset_constant.dart';
import 'package:flutter_report_app/features/sign_in/controllers/sign_in_controller.dart';
import 'package:flutter_report_app/shared/styles/color_style.dart';
import 'package:flutter_report_app/shared/styles/google_text_style.dart';
import 'package:flutter_report_app/shared/widgets/button/button_widget_custom.dart';
import 'package:flutter_report_app/shared/widgets/text_field/text_field_widget_custom.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = SignInController.to;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(25.w, 60.w, 25.w, 0),
          child: Form(
            key: controller.formKey,
            child: ListView(
              children: [
                Center(
                  child: Image.asset(
                    GlobalAssetConstant.imgLogoBas,
                    width: 144.w,
                  ),
                ),
                SizedBox(height: 39.w),
                Text(
                  'Login Akun',
                  style: blackTextStyle.copyWith(
                    fontWeight: bold,
                    fontSize: 24.sp,
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  'Selamat datang, silahkan login ke akun yang sudah didaftarkan',
                  style: greyTextStyle,
                ),
                SizedBox(height: 30.h),
                TextFieldWidgetCustom(
                  controller: controller.emailCtrl,
                  hint: 'Email',
                  contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.w),
                  prefixIcon: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 14.w),
                    child: SvgPicture.asset(
                      clipBehavior: Clip.none,
                      GlobalAssetConstant.icUser,
                    ),
                  ),
                ),
                Obx(
                  () => Visibility(
                    visible: controller.emailErrorText.isEmpty ? false : true,
                    child: Container(
                      margin: EdgeInsets.only(top: 10.w),
                      child: Text(
                        controller.emailErrorText.value,
                        style: redTextStyle.copyWith(
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Obx(
                  () => TextFieldWidgetCustom(
                    controller: controller.passwordCtrl,
                    keyboardType: TextInputType.visiblePassword,
                    isPassword: controller.isShowPassword.isTrue ? false : true,
                    hint: 'Password',
                    hintStyle: greyTextStyle,
                    contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.w),
                    maxLines: 1,
                    prefixIcon: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.w),
                      child: SvgPicture.asset(
                        clipBehavior: Clip.none,
                        GlobalAssetConstant.icLock,
                      ),
                    ),
                    suffixIcon: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 12.h,
                      ),
                      child: InkWell(
                        onTap: () {
                          if (controller.isShowPassword.value == false) {
                            controller.isShowPassword.value = true;
                          } else {
                            controller.isShowPassword.value = false;
                          }
                        },
                        child: Obx(
                          () => SvgPicture.asset(
                            clipBehavior: Clip.none,
                            controller.isShowPassword.isTrue
                                ? GlobalAssetConstant.icEye
                                : GlobalAssetConstant.icEyeSlash,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => Visibility(
                    visible: controller.passwordErrorText.isEmpty ? false : true,
                    child: Container(
                      margin: EdgeInsets.only(top: 10.w),
                      child: Text(
                        controller.passwordErrorText.value,
                        style: redTextStyle.copyWith(
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15.w),
                InkWell(
                  onTap: () {
                    Get.toNamed(Routes.forgotPasswordRoute);
                  },
                  child: Text(
                    'Lupa Password ?',
                    style: blueTextStyle.copyWith(
                      fontWeight: semiBold,
                      fontSize: 12.sp,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
                SizedBox(height: 40.w),
                Obx(
                  () => ButtonWidgetCustom(
                    height: 42.w,
                    text: 'Login',
                    color: controller.isDisable.isTrue ? Colors.grey.shade200 : ColorStyle.primary,
                    textStyle: whiteTextStyle.copyWith(fontSize: 14.sp),
                    onPressed: () =>
                        controller.isDisable.isTrue ? null : controller.validateForm(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
