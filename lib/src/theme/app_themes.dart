import 'package:flutter/material.dart';

sealed class BaseTheme {
  Color get primary;
  Color get secondary;
  Color get accent;
  Color get textPrimary;
  Color get textSecondary;
  Color get textAccent;
  Color get background;
  Color get foreground;
  Color get textFieldFill;
  Color get textFieldHint;
  Color get textFieldBorder;
  Color get textFieldAction;
  Color get error;
}

class FakeStoreLight extends BaseTheme {
  @override
  Color get primary => const Color(0xFF1E1E1E);

  @override
  Color get secondary => Colors.black;

  @override
  Color get accent => const Color(0xFFFFE8B2);

  @override
  Color get textPrimary => primary;

  @override
  Color get textSecondary => Colors.black.withOpacity(.6);

  @override
  Color get textAccent => const Color(0xFFA6A6AA);

  @override
  Color get background => Colors.white;

  @override
  Color get foreground => Colors.black.withOpacity(.05);

  @override
  Color get textFieldFill => const Color(0xFFF7F8F9);

  @override
  Color get textFieldHint => const Color(0xFF8391A1);

  @override
  Color get textFieldBorder => const Color(0xFFE8ECF4);

  @override
  Color get textFieldAction => const Color(0xFF6A707C);

  @override
  Color get error => const Color(0xFFCC474E);
}
