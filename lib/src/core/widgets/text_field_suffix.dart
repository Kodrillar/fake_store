import 'package:fake_store/src/core/extensions/build_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TextFieldSuffixIcon extends StatelessWidget {
  const TextFieldSuffixIcon(this.icon, {super.key, this.onTap});
  final String icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 10,
        width: 10,
        child: Center(
          child: SvgPicture.asset(
            icon,
            colorFilter: ColorFilter.mode(
              context.appTheme.textFieldAction,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}
