import 'package:fake_store/src/core/extensions/build_context.dart';
import 'package:fake_store/src/core/widgets/app_primary_button.dart';
import 'package:fake_store/src/core/widgets/app_scaffold.dart';
import 'package:fake_store/src/core/widgets/app_text_field.dart';
import 'package:fake_store/src/core/widgets/text_field_suffix.dart';
import 'package:fake_store/src/res/app_spacers.dart';
import 'package:fake_store/src/res/app_svgs.dart';
import 'package:fake_store/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:screendapt/screendapt.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Column(
        children: [
          const LoginScreenAppBar(),
          Spacers.h10,
          Expanded(
            child: SingleChildScrollView(
              child: SContainer(
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.topLeft,
                      child: LoginHeaderText(),
                    ),
                    Spacers.h30,
                    const AppTextField(
                      hintText: 'Enter your username',
                    ),
                    Spacers.h15,
                    const AppTextField(
                      hintText: 'Enter your password',
                      suffix: TextFieldSuffixIcon(AppSvgs.eyeShow),
                      obscureText: true,
                    ),
                    Spacers.h30,
                    SizedBox(
                      width: double.infinity,
                      child: AppPrimaryButton(
                        child: const SText('Login'),
                        onPressed: () => context.pushNamed(AppRoutes.home.name),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class LoginHeaderText extends StatelessWidget {
  const LoginHeaderText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(right: 25),
      child: SText(
        'Welcome back! Glad to see you, Again!',
        textAlign: TextAlign.left,
        style:
            TextStyle(fontSize: 28, fontWeight: FontWeight.bold, height: 1.2),
      ),
    );
  }
}

class LoginScreenAppBar extends StatelessWidget {
  const LoginScreenAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: SContainer(
        child: Align(
          alignment: Alignment.topLeft,
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: context.appTheme.secondary.withOpacity(.15)),
            ),
            child: InkWell(
              onTap: () => context.pop(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(AppSvgs.backArrow),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
