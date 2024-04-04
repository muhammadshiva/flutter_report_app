import 'package:flutter_report_app/configs/routes/route.dart';
import 'package:flutter_report_app/features/sign_in/bindings/sign_in_binding.dart';
import 'package:flutter_report_app/features/sign_in/view/ui/sign_in_screen.dart';
import 'package:flutter_report_app/features/splash/bindings/splash_binding.dart';
import 'package:flutter_report_app/features/splash/view/ui/splash_screen.dart';
import 'package:get/get.dart';

abstract class Pages {
  static final pages = [
    /// Splash Screen
    GetPage(
      name: Routes.splashRoute,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),

    GetPage(
      name: Routes.signInRoute,
      page: () => const SignInScreen(),
      binding: SingInBinding(),
    ),
  ];
}
