import 'package:flutter/material.dart';
import 'package:flutter_report_app/constants/global_asset_constant.dart';
import 'package:flutter_report_app/features/sign_in/controllers/sign_in_controller.dart';
import 'package:flutter_report_app/shared/styles/color_style.dart';
import 'package:flutter_report_app/shared/styles/google_text_style.dart';
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
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'User ID',
                  hintStyle: greyTextStyle,
                  contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                  prefixIcon: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 14.h),
                    child: SvgPicture.asset(
                      clipBehavior: Clip.none,
                      GlobalAssetConstant.icUser,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xffBBBDC7)),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xffBBBDC7)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: greyTextStyle,
                  contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
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
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xffBBBDC7)),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xffBBBDC7)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: 15.h),
              InkWell(
                onTap: () {},
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
