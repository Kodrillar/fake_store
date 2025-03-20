import 'package:fake_store/src/core/extensions/build_context.dart';
import 'package:flutter/material.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      strokeWidth: 8,
      valueColor: AlwaysStoppedAnimation(context.appTheme.textAccent),
    );
  }
}
