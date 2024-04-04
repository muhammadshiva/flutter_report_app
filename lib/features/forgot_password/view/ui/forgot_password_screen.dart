import 'package:flutter/material.dart';
import 'package:flutter_report_app/constants/global_asset_constant.dart';
import 'package:flutter_report_app/shared/styles/color_style.dart';
import 'package:flutter_report_app/shared/styles/google_text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: Image.asset(
              GlobalAssetConstant.imgLogoBas,
              height: 18.h,
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          SizedBox(height: 35.h),
          Text(
            'Lupa Password',
            textAlign: TextAlign.center,
            style: blackTextStyle.copyWith(
              fontSize: 20,
              fontWeight: semiBold,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            'Silahkan hubungi admin dengan klik tombol dibawah',
            textAlign: TextAlign.center,
            style: greyTextStyle.copyWith(
              fontSize: 12,
              fontWeight: semiBold,
            ),
          ),
          SizedBox(height: 25.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 100.w),
            height: 42.h,
            width: 100.w,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: ColorStyle.greenWa, // Warna latar belakang
              ),
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(GlobalAssetConstant.icWhatsApp),
                  SizedBox(width: 7.w),
                  Text(
                    'Admin BAS',
                    style: whiteTextStyle.copyWith(
                      fontWeight: semiBold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
