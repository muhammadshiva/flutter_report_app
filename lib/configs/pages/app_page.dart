import 'package:bas_app/configs/routes/app_route.dart';
import 'package:bas_app/features/ayak_manual/bindings/ayak_manual_binding.dart';
import 'package:bas_app/features/ayak_manual/bindings/ayak_manual_query_binding.dart';
import 'package:bas_app/features/ayak_manual/view/ui/ayak_manual_query_screen.dart';
import 'package:bas_app/features/ayak_manual/view/ui/ayak_manual_screen.dart';
import 'package:bas_app/features/ayak_rotari/bindings/ayak_rotari_binding.dart';
import 'package:bas_app/features/ayak_rotari/bindings/ayak_rotari_query_binding.dart';
import 'package:bas_app/features/ayak_rotari/view/ui/ayak_rotari_query_screen.dart';
import 'package:bas_app/features/ayak_rotari/view/ui/ayak_rotari_screen.dart';
import 'package:bas_app/features/bahan_baku/bindings/bahan_baku_binding.dart';
import 'package:bas_app/features/bahan_baku/bindings/bahan_baku_query_binding.dart';
import 'package:bas_app/features/bahan_baku/view/ui/bahan_baku_query_screen.dart';
import 'package:bas_app/features/bahan_baku/view/ui/bahan_baku_screen.dart';
import 'package:bas_app/features/batok/bindings/batok_binding.dart';
import 'package:bas_app/features/batok/bindings/batok_query_binding.dart';
import 'package:bas_app/features/batok/views/ui/batok_query_screen.dart';
import 'package:bas_app/features/batok/views/ui/batok_screen.dart';
import 'package:bas_app/features/briket/bindings/briket_binding.dart';
import 'package:bas_app/features/briket/bindings/briket_query_binding.dart';
import 'package:bas_app/features/briket/view/ui/briket_query_screen.dart';
import 'package:bas_app/features/briket/view/ui/briket_screen.dart';
import 'package:bas_app/features/diskmill/bindings/diskmill_binding.dart';
import 'package:bas_app/features/diskmill/bindings/diskmill_query_binding.dart';
import 'package:bas_app/features/diskmill/view/ui/diskmill_query_screen.dart';
import 'package:bas_app/features/diskmill/view/ui/diskmill_screen.dart';
import 'package:bas_app/features/forgot_password/bindings/forgot_password_binding.dart';
import 'package:bas_app/features/forgot_password/view/ui/forgot_password_screen.dart';
import 'package:bas_app/features/home/bindings/home_binding.dart';
import 'package:bas_app/features/home/view/ui/home_screen.dart';
import 'package:bas_app/features/mixing/bindings/mixing_binding.dart';
import 'package:bas_app/features/mixing/bindings/mixing_query_binding.dart';
import 'package:bas_app/features/mixing/view/ui/mixing_query_screen.dart';
import 'package:bas_app/features/mixing/view/ui/mixing_screen.dart';
import 'package:bas_app/features/no_connection/bindings/no_connection_binding.dart';
import 'package:bas_app/features/no_connection/views/ui/no_connection_screen.dart';
import 'package:bas_app/features/oven/bindings/oven_binding.dart';
import 'package:bas_app/features/oven/bindings/oven_query_binding.dart';
import 'package:bas_app/features/oven/view/ui/oven_query_screen.dart';
import 'package:bas_app/features/oven/view/ui/oven_screen.dart';
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

    //* BATOK
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

    //* BAHAN BAKU
    GetPage(
      name: AppRoute.bahanBakuRoute,
      page: () => const BahanBakuScreen(),
      binding: BahanBakuBinding(),
    ),

    GetPage(
      name: AppRoute.bahanBakuQueryRoute,
      page: () => const BahanBakuQueryScreen(),
      binding: BahanBakuQueryBinding(),
    ),

    //* AYAK MANUAL
    GetPage(
      name: AppRoute.ayakManualRoute,
      page: () => const AyakManualScreen(),
      binding: AyakManualBinding(),
    ),

    GetPage(
      name: AppRoute.ayakManualQueryRoute,
      page: () => const AyakManualQueryScreen(),
      binding: AyakManualQueryBinding(),
    ),

    //* AYAK ROTARI
    GetPage(
      name: AppRoute.ayakRotariRoute,
      page: () => const AyakRotariScreen(),
      binding: AyakRotariBinding(),
    ),

    GetPage(
      name: AppRoute.ayakRotariQueryRoute,
      page: () => const AyakRotariQueryScreen(),
      binding: AyakRotariQueryBinding(),
    ),

    //* DISKMILL
    GetPage(
      name: AppRoute.diskmillRoute,
      page: () => const DiskmillScreen(),
      binding: DiskmillBinding(),
    ),

    GetPage(
      name: AppRoute.diskmillQueryRoute,
      page: () => const DiskmillQueryScreen(),
      binding: DiskmillQueryBinding(),
    ),

    //* MIXING
    GetPage(
      name: AppRoute.mixingRoute,
      page: () => const MixingScreen(),
      binding: MixingBinding(),
    ),

    GetPage(
      name: AppRoute.mixingQueryRoute,
      page: () => const MixingQueryScreen(),
      binding: MixingQueryBinding(),
    ),

    //* OVEN
    GetPage(
      name: AppRoute.ovenRoute,
      page: () => const OvenScreen(),
      binding: OvenBinding(),
    ),

    GetPage(
      name: AppRoute.ovenQueryRoute,
      page: () => const OvenQueryScreen(),
      binding: OvenQueryBinding(),
    ),

    //* BRIKET
    GetPage(
      name: AppRoute.briketRoute,
      page: () => const BriketScreen(),
      binding: BriketBinding(),
    ),

    GetPage(
      name: AppRoute.briketQueryRoute,
      page: () => const BriketQueryScreen(),
      binding: BriketQueryBinding(),
    ),
  ];
}
