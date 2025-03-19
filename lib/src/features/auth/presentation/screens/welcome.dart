import 'package:fake_store/src/core/widgets/app_primary_button.dart';
import 'package:fake_store/src/core/widgets/app_scaffold.dart';
import 'package:fake_store/src/res/app_images.dart';
import 'package:fake_store/src/res/app_spacers.dart';
import 'package:fake_store/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:screendapt/screendapt.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      body: Stack(
        children: [
          WelcomeBackgroundImage(),
          SContainer(
            padding: EdgeInsets.all(20),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: WelcomeContents(),
            ),
          ),
        ],
      ),
    );
  }
}

class WelcomeContents extends StatelessWidget {
  const WelcomeContents({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Spacer(),
        const Spacer(),
        const Spacer(),
        const AppLogo(),
        Spacers.h15,
        const SText(
          'Fake Store',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 30),
        AppPrimaryButton(
          child: const SText('Login'),
          onPressed: () => context.pushNamed(AppRoutes.login.name),
        ),
        const Spacer()
      ],
    );
  }
}

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 50,
      child: Image.asset(AppImages.appLogo),
    );
  }
}

class WelcomeBackgroundImage extends StatelessWidget {
  const WelcomeBackgroundImage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Image.asset(
        AppImages.welcome,
        fit: BoxFit.cover,
      ),
    );
  }
}
