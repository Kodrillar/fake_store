import 'package:fake_store/src/core/extensions/build_context.dart';
import 'package:fake_store/src/res/app_fonts.dart';
import 'package:flutter/material.dart';

class AppThemeData {
  static ThemeData getThemeData(BuildContext context) => ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: context.appTheme.primary),
        fontFamily: AppFonts.urbanist,
        useMaterial3: true,
        scaffoldBackgroundColor: context.appTheme.background,
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: context.appTheme.textPrimary),
        ),
      );
}
