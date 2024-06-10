import 'package:bas_app/configs/pages/app_page.dart';
import 'package:bas_app/configs/routes/app_route.dart';
import 'package:bas_app/shared/bindings/global_binding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'configs/themes/theme.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox("bas");

  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null).then(
    (_) => runApp(
      const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'BAS Report',
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'), //* English
            Locale('id_ID'), //* Indonesia
          ],
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoute.splashRoute,
          initialBinding: GlobalBinding(),
          theme: themeLight,
          getPages: AppPage.pages,
        );
      },
    );
  }
}
