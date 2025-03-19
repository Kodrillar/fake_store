import 'package:flutter/material.dart';
import 'package:screendapt/screendapt.dart';

class ButtonText extends StatelessWidget {
  const ButtonText(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return SText(
      text,
      style: const TextStyle(fontWeight: FontWeight.w600),
    );
  }
}
