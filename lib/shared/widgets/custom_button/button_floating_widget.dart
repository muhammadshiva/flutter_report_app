import 'package:bas_app/constants/global_asset_constant.dart';
import 'package:bas_app/shared/styles/color_style.dart';
import 'package:bas_app/shared/styles/google_text_style.dart';
import 'package:bas_app/shared/widgets/custom_button/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonFloatingWidget extends StatelessWidget {
  const ButtonFloatingWidget(
      {super.key, required this.onPressedInputData, required this.onPressedExportData});

  final Function() onPressedInputData;
  final Function() onPressedExportData;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ButtonWidget(
            icon: GlobalAssetConstant.icInputData,
            iconSize: 17.w,
            width: 160.w,
            text: 'Input Data',
            color: ColorStyle.primary,
            textStyle: whiteTextStyle,
            onPressed: onPressedInputData,
          ),
          5.horizontalSpace,
          ButtonWidget(
            icon: GlobalAssetConstant.icExport,
            text: 'Export Data',
            width: 160.w,
            color: ColorStyle.primary,
            textStyle: whiteTextStyle,
            onPressed: onPressedExportData,
          ),
        ],
      ),
    );
  }
}
