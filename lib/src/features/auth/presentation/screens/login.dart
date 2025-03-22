import 'package:fake_store/src/core/extensions/build_context.dart';
import 'package:fake_store/src/core/utils/async_state.dart';
import 'package:fake_store/src/core/widgets/app_primary_button.dart';
import 'package:fake_store/src/core/widgets/app_scaffold.dart';
import 'package:fake_store/src/core/widgets/app_snack_bar.dart';
import 'package:fake_store/src/core/widgets/app_text_field.dart';
import 'package:fake_store/src/core/widgets/button_loader.dart';
import 'package:fake_store/src/core/widgets/button_text.dart';
import 'package:fake_store/src/core/widgets/text_field_suffix.dart';
import 'package:fake_store/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:fake_store/src/features/auth/presentation/bloc/auth_events.dart';
import 'package:fake_store/src/features/auth/presentation/bloc/auth_state.dart';
import 'package:fake_store/src/features/auth/domain/login_data.dart';
import 'package:fake_store/src/res/app_spacers.dart';
import 'package:fake_store/src/res/app_svgs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:screendapt/screendapt.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _logIn(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().logIn(
            LoginData(
              username: _usernameController.text.trim(),
              password: _passwordController.text.trim(),
            ),
          );
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listenWhen: (previous, current) =>
          current.asyncState is AsyncError &&
          previous.asyncState is! AsyncError,
      listener: (context, state) {
        if (state.asyncState is AsyncError) {
          AppSnackBar.show(context,
              message: (state.asyncState as AsyncError).error.toString());
        }
      },
      builder: (context, state) => Form(
        key: _formKey,
        child: AppScaffold(
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
                        AppTextField(
                          hintText: 'Enter your username',
                          controller: _usernameController,
                        ),
                        Spacers.h15,
                        AppTextField(
                          controller: _passwordController,
                          hintText: 'Enter your password',
                          suffix: TextFieldSuffixIcon(
                            state.obscureText
                                ? AppSvgs.eyeHide
                                : AppSvgs.eyeShow,
                            onTap: () => context
                                .read<AuthBloc>()
                                .add(ObscureTextEvent(!state.obscureText)),
                          ),
                          obscureText: state.obscureText,
                        ),
                        Spacers.h30,
                        SizedBox(
                          width: double.infinity,
                          child: AppPrimaryButton(
                            onPressed: () => _logIn(context),
                            child: context
                                    .watch<AuthBloc>()
                                    .state
                                    .asyncState
                                    .isLoading
                                ? const ButtonLoader()
                                : const ButtonText('Login'),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
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
