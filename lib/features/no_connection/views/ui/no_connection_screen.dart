import 'package:flutter/material.dart';
import 'package:flutter_report_app/constants/global_asset_constant.dart';
import 'package:flutter_report_app/features/no_connection/controllers/no_connection_controller.dart';
import 'package:flutter_report_app/shared/styles/color_style.dart';
import 'package:flutter_report_app/shared/widgets/elevated_button_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class NoConnectionScreen extends StatelessWidget {
  const NoConnectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = NoConnectionController.to;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(GlobalAssetConstant.icNoConnection),
            SizedBox(height: 15.w),
            Text(
              'Tidak ada koneksi internet',
              style: GoogleFonts.poppins().copyWith(
                fontSize: 14.sp,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 25.w),
            ElevatedButtonWidget(
              text: 'Check Connection',
              color: ColorStyle.primary,
              textStyle: GoogleFonts.poppins().copyWith(
                fontSize: 14.sp,
              ),
              onPressed: () => controller.checkConnection(context),
            ),
          ],
        ),
      ),
    );
  }
}
