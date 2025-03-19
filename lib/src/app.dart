import 'package:fake_store/src/routing/app_router.dart';
import 'package:fake_store/src/theme/app_theme.dart';
import 'package:fake_store/src/theme/app_theme_data.dart';
import 'package:fake_store/src/theme/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:screendapt/screendapt.dart';

class FakeStoreApp extends StatelessWidget {
  const FakeStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppTheme(
      theme: FakeStoreLight(),
      child: ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (context, _) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: AppThemeData.getThemeData(context),
              routerConfig: goRouter,
            );
          }),
    );
  }
}
