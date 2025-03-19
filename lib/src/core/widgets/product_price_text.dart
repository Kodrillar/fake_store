import 'package:fake_store/src/core/extensions/build_context.dart';
import 'package:flutter/material.dart';
import 'package:screendapt/screendapt.dart';

class ProductPriceText extends StatelessWidget {
  const ProductPriceText(this.price, {super.key, this.color});

  final String price;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SText(
      price,
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 12,
        color: color ?? context.appTheme.primary.withOpacity(.75),
      ),
    );
  }
}
