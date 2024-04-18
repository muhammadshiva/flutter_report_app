import 'package:flutter/material.dart';
import 'package:flutter_report_app/configs/routes/route.dart';
import 'package:flutter_report_app/constants/global_asset_constant.dart';
import 'package:flutter_report_app/features/production/controllers/production_controller.dart';
import 'package:flutter_report_app/features/production/view/components/production_data_list_widget.dart';
import 'package:flutter_report_app/features/production/view/components/production_filter_widget.dart';
import 'package:flutter_report_app/features/production/view/components/production_persentase_widget.dart';
import 'package:flutter_report_app/features/production/view/components/production_tab_widget.dart';
import 'package:flutter_report_app/shared/styles/color_style.dart';
import 'package:flutter_report_app/shared/styles/google_text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProductionScreen extends StatelessWidget {
  const ProductionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = ProductionController.to;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          controller.titleMenu.value,
          style: blackTextStyle.copyWith(
            fontSize: 17.sp,
            fontWeight: semiBold,
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
      body: ListView(
        children: [
          ProductionTabWidget(),
          ProductionPersentaseWidget(),
          ProductionFilterWidget(),
          ProductionDataListWidget(),
        ],
      ),
      floatingActionButton: InkWell(
        onTap: () {
          Get.toNamed(
            Routes.productionInputRoute,
          );
          debugPrint('ID MENU : ${controller.idMenu.value}');
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
