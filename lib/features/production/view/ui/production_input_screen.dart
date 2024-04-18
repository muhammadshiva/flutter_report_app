import 'package:flutter/material.dart';
import 'package:flutter_report_app/features/production/controllers/production_controller.dart';
import 'package:flutter_report_app/features/production/view/pages/bahan_baku_page.dart';
import 'package:flutter_report_app/features/production/view/pages/batok_page.dart';
import 'package:flutter_report_app/shared/styles/color_style.dart';
import 'package:flutter_report_app/shared/styles/google_text_style.dart';
import 'package:flutter_report_app/shared/widgets/elevated_button_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductionInputScreen extends StatelessWidget {
  const ProductionInputScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = ProductionController.to;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Input Data',
          style: blackTextStyle.copyWith(
            fontSize: 17.sp,
            fontWeight: semiBold,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 25.w,
          vertical: 30.h,
        ),
        child: controller.idMenu.value == 1 ? BatokPage() : BahanBakuPage(),
      ),
      floatingActionButton: Container(
        decoration: const BoxDecoration(
          color: ColorStyle.white,
          boxShadow: [
            BoxShadow(
              color: Color(0x40000000),
              offset: Offset(0, -1),
              blurRadius: 2,
              spreadRadius: 0,
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 25.h),
        child: ElevatedButtonWidget(
          width: double.infinity,
          text: 'Simpan Data',
          color: ColorStyle.primary,
          textStyle: whiteTextStyle.copyWith(fontSize: 14.sp),
          onPressed: () {
            debugPrint('ID MENU KEEP : ${controller.idMenu.value}');
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
