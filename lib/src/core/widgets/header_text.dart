import 'package:flutter/material.dart';
import 'package:screendapt/screendapt.dart';

class HeaderText extends StatelessWidget {
  const HeaderText(this.text, {super.key, this.fontSize});
  final String text;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return SText(
      text,
      style: TextStyle(
        height: 1.25,
        fontSize: fontSize ?? 22,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
