import 'package:fake_store/src/features/home/presentation/home.dart';
import 'package:fake_store/src/theme/app_theme.dart';
import 'package:fake_store/src/theme/app_theme_data.dart';
import 'package:fake_store/src/theme/app_themes.dart';
import 'package:flutter/material.dart';

class FakeStoreApp extends StatelessWidget {
  const FakeStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppTheme(
      theme: FakeStoreLight(),
      child: Builder(builder: (context) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: AppThemeData.getThemeData(context),
          home: const HomeScreen(),
        );
      }),
    );
  }
}
