import 'package:flutter_report_app/configs/routes/route.dart';
import 'package:flutter_report_app/features/splash/bindings/splash_binding.dart';
import 'package:flutter_report_app/features/splash/view/ui/splash_screen.dart';
import 'package:get/get.dart';

abstract class Pages {
  static final pages = [
    /// Splash Screen
    GetPage(
      name: Routes.splashRoute,
      page: () => SplashScreen(),
      binding: SplashBinding(),
    ),
  ];
}
