import 'package:flutter/material.dart';
import 'package:flutter_report_app/constants/global_asset_constant.dart';
import 'package:flutter_report_app/features/home/view/components/home_data_list_widget.dart';
import 'package:flutter_report_app/features/home/view/components/home_tab_widget.dart';
import 'package:flutter_report_app/shared/styles/google_text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Proses Produksi',
          style: blackTextStyle.copyWith(
            fontSize: 17.sp,
            fontWeight: semiBold,
          ),
        ),
        actions: [
          Container(
            height: 22.h,
            margin: EdgeInsets.only(right: 12.w),
            child: Image.asset(
              GlobalAssetConstant.imgLogoBas,
            ),
          ),
        ],
      ),
      body: ListView(
        children: const [
          HomeTabWidget(),
          HomeDataListWidget(),
        ],
      ),
    );
  }
}
