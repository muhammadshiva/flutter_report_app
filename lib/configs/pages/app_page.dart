import 'package:bas_app/configs/routes/app_route.dart';
import 'package:bas_app/features/batok/bindings/batok_binding.dart';
import 'package:bas_app/features/batok/bindings/batok_query_binding.dart';
import 'package:bas_app/features/batok/views/ui/batok_query_screen.dart';
import 'package:bas_app/features/batok/views/ui/batok_screen.dart';
import 'package:bas_app/features/forgot_password/bindings/forgot_password_binding.dart';
import 'package:bas_app/features/forgot_password/view/ui/forgot_password_screen.dart';
import 'package:bas_app/features/home/bindings/home_binding.dart';
import 'package:bas_app/features/home/view/ui/home_screen.dart';
import 'package:bas_app/features/no_connection/bindings/no_connection_binding.dart';
import 'package:bas_app/features/no_connection/views/ui/no_connection_screen.dart';
import 'package:bas_app/features/sign_in/bindings/sign_in_binding.dart';
import 'package:bas_app/features/sign_in/view/ui/sign_in_screen.dart';
import 'package:bas_app/features/splash/bindings/splash_binding.dart';
import 'package:bas_app/features/splash/view/ui/splash_screen.dart';
import 'package:get/get.dart';

abstract class AppPage {
  static final pages = [
    GetPage(
      name: AppRoute.noConnectionRoute,
      page: () => const NoConnectionScreen(),
      binding: NoConnectionBinding(),
    ),

    /// Splash Screen
    GetPage(
      name: AppRoute.splashRoute,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),

    GetPage(
      name: AppRoute.signInRoute,
      page: () => const SignInScreen(),
      binding: SingInBinding(),
    ),

    GetPage(
      name: AppRoute.forgotPasswordRoute,
      page: () => const ForgotPasswordScreen(),
      binding: ForgotPasswordBinding(),
    ),

    GetPage(
      name: AppRoute.homeRoute,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),

    GetPage(
      name: AppRoute.batokRoute,
      page: () => const BatokScreen(),
      binding: BatokBinding(),
    ),

    GetPage(
      name: AppRoute.batokQueryRoute,
      page: () => const BatokQueryScreen(),
      binding: BatokQueryBinding(),
    ),

    GetPage(
      name: AppRoute.bahanBakuRoute,
      page: () => const BatokScreen(),
      binding: BatokBinding(),
    ),
  ];
}
