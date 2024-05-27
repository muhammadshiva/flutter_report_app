import 'package:flutter/material.dart';
import 'package:flutter_report_app/configs/routes/route.dart';
import 'package:flutter_report_app/constants/global_asset_constant.dart';
import 'package:flutter_report_app/features/batok/models/batok_model.dart';
import 'package:flutter_report_app/features/batok/views/components/batok_filter_widget.dart';
import 'package:flutter_report_app/features/batok/views/components/batok_list_widget.dart';
import 'package:flutter_report_app/features/batok/views/components/batok_persentase_widget.dart';
import 'package:flutter_report_app/features/batok/views/components/batok_tab_widget.dart';
import 'package:flutter_report_app/features/batok/views/ui/batok_query_screen.dart';
import 'package:flutter_report_app/shared/styles/color_style.dart';
import 'package:flutter_report_app/shared/styles/google_text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class BatokScreen extends StatelessWidget {
  const BatokScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Batok',
          style: blackTextStyle.copyWith(
            fontSize: 17.sp,
            fontWeight: semiBold,
          ),
        ),
        leading: InkWell(
          onTap: () {
            Get.offAllNamed(Routes.homeRoute);
          },
          child: const Icon(
            Icons.arrow_back,
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            color: ColorStyle.white,
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'export',
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset(
                        GlobalAssetConstant.icExportFile,
                      ),
                      Text(
                        'Export',
                        style: blackTextStyle.copyWith(
                          color: ColorStyle.black2,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
            onSelected: (String value) {
              if (value == 'export') {}
            },
          ),
        ],
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            BatokTab(),
            BatokPersentase(),
            BatokFilter(totalData: 3),
            BatokList(),
          ],
        ),
      ),
      floatingActionButton: InkWell(
        onTap: () {
          Get.to(
            BatokQueryScreen(isEdit: false, data: ListBatok()),
            fullscreenDialog: true,
          );
        },
        child: Container(
          height: 40.h,
          width: 120.w,
          decoration: BoxDecoration(
            color: ColorStyle.b4,
            borderRadius: BorderRadius.circular(23.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.add,
                color: ColorStyle.white,
                size: 20,
              ),
              SizedBox(width: 5.w),
              Text(
                "Input Data",
                style: whiteTextStyle.copyWith(
                  fontWeight: medium,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
