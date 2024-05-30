import 'package:flutter/material.dart';
import 'package:flutter_report_app/configs/routes/route.dart';
import 'package:flutter_report_app/constants/global_asset_constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_report_app/shared/styles/color_style.dart';
import 'package:flutter_report_app/shared/styles/google_text_style.dart';

class AppBarWidgetCustom extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;

  const AppBarWidgetCustom({
    Key? key,
    required this.title,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        title,
        style: blackTextStyle.copyWith(
          fontSize: 17.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      leading: InkWell(
        onTap: () {
          Get.until((route) => Get.currentRoute == Routes.homeRoute);
        },
        child: const Icon(
          Icons.arrow_back,
        ),
      ),
      actions: actions ??
          [
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
                if (value == 'export') {
                  // Handle export action
                }
              },
            ),
          ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
