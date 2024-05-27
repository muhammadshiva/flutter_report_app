import 'package:flutter_report_app/configs/routes/route.dart';
import 'package:flutter_report_app/features/ayak_manual/bindings/ayak_manual_binding.dart';
import 'package:flutter_report_app/features/ayak_manual/views/ui/ayak_mannual_screen.dart';
import 'package:flutter_report_app/features/ayak_rotari/bindings/ayak_rotari_binding.dart';
import 'package:flutter_report_app/features/ayak_rotari/views/ui/ayak_mannual_screen.dart';
import 'package:flutter_report_app/features/bahan_baku/bindings/bahan_baku_binding.dart';
import 'package:flutter_report_app/features/bahan_baku/views/ui/bahan_baku_screen.dart';
import 'package:flutter_report_app/features/batok/bindings/batok_binding.dart';
import 'package:flutter_report_app/features/batok/views/ui/batok_screen.dart';
import 'package:flutter_report_app/features/briket/bindings/briket_binding.dart';
import 'package:flutter_report_app/features/briket/views/ui/briket_screen.dart';
import 'package:flutter_report_app/features/diskmill/bindings/diskmill_binding.dart';
import 'package:flutter_report_app/features/diskmill/views/ui/diskmill_screen.dart';
import 'package:flutter_report_app/features/forgot_password/bindings/forgot_password_binding.dart';
import 'package:flutter_report_app/features/forgot_password/view/ui/forgot_password_screen.dart';
import 'package:flutter_report_app/features/home/bindings/home_binding.dart';
import 'package:flutter_report_app/features/home/view/ui/home_screen.dart';
import 'package:flutter_report_app/features/mixing/bindings/mixing_binding.dart';
import 'package:flutter_report_app/features/mixing/views/ui/mixing_screen.dart';
import 'package:flutter_report_app/features/no_connection/bindings/no_connection_binding.dart';
import 'package:flutter_report_app/features/no_connection/views/ui/no_connection_screen.dart';
import 'package:flutter_report_app/features/oven/bindings/oven_binding.dart';
import 'package:flutter_report_app/features/oven/views/ui/oven_screen.dart';

import 'package:flutter_report_app/features/sign_in/bindings/sign_in_binding.dart';
import 'package:flutter_report_app/features/sign_in/view/ui/sign_in_screen.dart';
import 'package:flutter_report_app/features/splash/bindings/splash_binding.dart';
import 'package:flutter_report_app/features/splash/view/ui/splash_screen.dart';
import 'package:get/get.dart';

abstract class Pages {
  static final pages = [
    GetPage(
      name: Routes.noConnectionRoute,
      page: () => const NoConnectionScreen(),
      binding: NoConnectionBinding(),
    ),

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

    //* BAHAN BAKU
    GetPage(
      name: Routes.batokRoute,
      page: () => const BatokScreen(),
      binding: BatokBinding(),
    ),

    //* BAHAN BAKU
    GetPage(
      name: Routes.bahanBakuRoute,
      page: () => const BahanBakuScreen(),
      binding: BahanBakuBinding(),
    ),

    //* AYAK MANUAL
    GetPage(
      name: Routes.ayakManualRoute,
      page: () => const AyakManualScreen(),
      binding: AyakManualBinding(),
    ),

    //* AYAK ROTARI
    GetPage(
      name: Routes.ayakRotariRoute,
      page: () => const AyakRotariScreen(),
      binding: AyakRotariBinding(),
    ),

    //* DISKMILL
    GetPage(
      name: Routes.diskmillRoute,
      page: () => const DiskmillScreen(),
      binding: DiskmillBinding(),
    ),

    //* MIXING
    GetPage(
      name: Routes.mixingRoute,
      page: () => const MixingScreen(),
      binding: MixingBinding(),
    ),

    //* OVEN
    GetPage(
      name: Routes.ovenRoute,
      page: () => const OvenScreen(),
      binding: OvenBinding(),
    ),

    //* BRIKET
    GetPage(
      name: Routes.briketRoute,
      page: () => const BriketScreen(),
      binding: BriketBinding(),
    ),
  ];
}
