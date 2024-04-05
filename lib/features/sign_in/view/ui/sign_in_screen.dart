import 'package:flutter/material.dart';
import 'package:flutter_report_app/configs/routes/route.dart';
import 'package:flutter_report_app/constants/global_asset_constant.dart';
import 'package:flutter_report_app/features/sign_in/controllers/sign_in_controller.dart';
import 'package:flutter_report_app/shared/styles/color_style.dart';
import 'package:flutter_report_app/shared/styles/google_text_style.dart';
import 'package:flutter_report_app/shared/widgets/text_form_field_widget.dart';
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
          padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 62.h),
          child: ListView(
            children: [
              Center(
                child: Image.asset(
                  GlobalAssetConstant.imgLogoBas,
                  width: 144.w,
                ),
              ),
              SizedBox(height: 39.h),
              Text(
                'Login Akun',
                style: blackTextStyle.copyWith(
                  fontWeight: bold,
                  fontSize: 24,
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                'Selamat datang, silahkan login ke kaun yang sudah didaftarkan',
                style: greyTextStyle,
              ),
              SizedBox(height: 30.h),
              TextFormFieldWidget(
                hint: 'User ID',
                contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                prefixIcon: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 14.h),
                  child: SvgPicture.asset(
                    clipBehavior: Clip.none,
                    GlobalAssetConstant.icUser,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Obx(
                () => TextFormFieldWidget(
                  keyboardType: TextInputType.visiblePassword,
                  isPassword: controller.isShowPassword.isTrue ? false : true,
                  hint: 'Password',
                  hintStyle: greyTextStyle,
                  contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                  maxLines: 1,
                  prefixIcon: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
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
                          controller.isShowPassword.isTrue ? GlobalAssetConstant.icEye : GlobalAssetConstant.icEyeSlash,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15.h),
              InkWell(
                onTap: () {
                  Get.toNamed(Routes.forgotPasswordRoute);
                },
                child: Text(
                  'Lupa Password ?',
                  style: blueTextStyle.copyWith(
                    fontWeight: semiBold,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
              SizedBox(height: 50.h),
              SizedBox(
                height: 42.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: ColorStyle.primary, // Warna latar belakang
                  ),
                  onPressed: () {},
                  child: Text(
                    'Login',
                    style: whiteTextStyle.copyWith(
                      fontWeight: semiBold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
