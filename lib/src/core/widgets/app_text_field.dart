import 'package:fake_store/src/core/extensions/build_context.dart';
import 'package:fake_store/src/core/utils/text_field_validators.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.hintText,
    this.suffix,
    this.controller,
    this.obscureText = false,
  });

  final String? hintText;
  final Widget? suffix;
  final bool obscureText;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    final errorBorder = OutlineInputBorder(
      borderSide: BorderSide(color: context.appTheme.error),
      borderRadius: BorderRadius.circular(10),
    );
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      obscureText: obscureText,
      validator: TextFieldValidators.generic,
      obscuringCharacter: "-",
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
