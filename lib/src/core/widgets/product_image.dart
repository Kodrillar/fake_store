import 'package:fake_store/src/core/extensions/build_context.dart';
import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  const ProductImage({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      height: 65,
      width: 65,
      decoration: BoxDecoration(
        color: context.appTheme.textAccent.withOpacity(.3),
        borderRadius: BorderRadius.circular(5),
        image: DecorationImage(
          image: Image.network(imageUrl).image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
