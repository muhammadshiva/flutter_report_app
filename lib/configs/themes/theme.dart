import 'package:bas_app/shared/styles/color_style.dart';
import 'package:bas_app/shared/styles/google_text_style.dart';
import 'package:flutter/material.dart';

final ThemeData themeLight = ThemeData(
  primaryColor: ColorStyle.primary,
  brightness: Brightness.light,
  scaffoldBackgroundColor: const Color(0xffFFFFFF),
  appBarTheme: AppBarTheme(
    titleTextStyle: softBlackTextStyle.copyWith(fontWeight: semiBold),
    iconTheme: const IconThemeData(color: ColorStyle.black2),
    foregroundColor: ColorStyle.white,
    backgroundColor: ColorStyle.white,
  ),
  dialogBackgroundColor: ColorStyle.white,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      textStyle: whiteTextStyle.copyWith(
        fontSize: 12,
        color: ColorStyle.white,
      ),
    ),
  ),
);
