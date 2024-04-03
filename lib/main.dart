import 'package:flutter/material.dart';
import 'package:flutter_report_app/configs/pages/page.dart';
import 'package:flutter_report_app/configs/routes/route.dart';
import 'package:flutter_report_app/configs/themes/theme.dart';
import 'package:flutter_report_app/shared/bindings/global_binding.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'BAS Report',
          debugShowCheckedModeBanner: false,
          initialRoute: Routes.splashRoute,
          initialBinding: GlobalBinding(),
          theme: themeLight,
          getPages: Pages.pages,
        );
      },
    );
  }
}
