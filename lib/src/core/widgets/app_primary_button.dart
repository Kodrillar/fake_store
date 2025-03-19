import 'package:fake_store/src/core/extensions/build_context.dart';
import 'package:flutter/material.dart';

class AppPrimaryButton extends StatelessWidget {
  const AppPrimaryButton({
    super.key,
    required this.child,
    this.onPressed,
  });

  final Widget child;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        fixedSize: const WidgetStatePropertyAll(Size.fromHeight(50)),
        backgroundColor: WidgetStatePropertyAll(context.appTheme.primary),
        overlayColor:
            WidgetStatePropertyAll(context.appTheme.background.withOpacity(.1)),
        foregroundColor: WidgetStatePropertyAll(context.appTheme.background),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
      child: child,
    );
  }
}
