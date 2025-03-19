import 'package:fake_store/src/core/extensions/build_context.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.hintText,
    this.suffix,
    this.obscureText = false,
  });

  final String? hintText;
  final Widget? suffix;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    final errorBorder = OutlineInputBorder(
      borderSide: BorderSide(color: context.appTheme.error),
      borderRadius: BorderRadius.circular(10),
    );
    return TextFormField(
      obscureText: obscureText,
      decoration: InputDecoration(
        filled: true,
        fillColor: context.appTheme.textFieldFill,
        hintText: hintText,
        suffixIcon: suffix,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
        hintStyle: TextStyle(
          color: context.appTheme.textFieldHint,
          fontWeight: FontWeight.w500,
          fontSize: 15,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: context.appTheme.textFieldBorder),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: context.appTheme.primary),
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: errorBorder,
        focusedErrorBorder: errorBorder,
      ),
    );
  }
}
