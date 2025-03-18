import 'package:fake_store/src/theme/app_theme.dart';
import 'package:fake_store/src/theme/app_themes.dart';
import 'package:flutter/material.dart';

extension BuildContextX on BuildContext {
  BaseTheme get appTheme => AppTheme.of(this);
}
