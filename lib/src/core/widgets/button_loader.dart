import 'package:fake_store/src/core/extensions/build_context.dart';
import 'package:flutter/material.dart';

class ButtonLoader extends StatelessWidget {
  const ButtonLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25,
      width: 25,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(context.appTheme.background),
      ),
    );
  }
}
