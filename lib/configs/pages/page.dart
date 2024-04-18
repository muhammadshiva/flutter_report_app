import 'package:flutter_report_app/configs/routes/route.dart';
import 'package:flutter_report_app/features/forgot_password/bindings/forgot_password_binding.dart';
import 'package:flutter_report_app/features/forgot_password/view/ui/forgot_password_screen.dart';
import 'package:flutter_report_app/features/home/bindings/home_binding.dart';
import 'package:flutter_report_app/features/home/view/ui/home_screen.dart';
import 'package:flutter_report_app/features/production/bindings/pre_production_binding.dart';
import 'package:flutter_report_app/features/production/view/ui/production_input_screen.dart';
import 'package:flutter_report_app/features/production/view/ui/production_screen.dart';
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

    GetPage(
      name: Routes.forgotPasswordRoute,
      page: () => const ForgotPasswordScreen(),
      binding: ForgotPasswordBinding(),
    ),

    GetPage(
      name: Routes.homeRoute,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),

    GetPage(
      name: Routes.productionRoute,
      page: () => const ProductionScreen(),
      binding: ProductionBinding(),
    ),

    GetPage(
      name: Routes.productionInputRoute,
      page: () => const ProductionInputScreen(),
      binding: ProductionBinding(),
    ),
  ];
}
