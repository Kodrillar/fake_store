import 'package:flutter/material.dart';
import 'package:screendapt/screendapt.dart';

class ProductNameText extends StatelessWidget {
  const ProductNameText(this.name, {super.key});

  final String name;

  @override
  Widget build(BuildContext context) {
    return SText(
      name,
      maxLines: 1,
      style: const TextStyle(
          fontWeight: FontWeight.w600, overflow: TextOverflow.ellipsis),
    );
  }
}
