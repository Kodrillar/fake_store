import 'package:fake_store/src/core/extensions/build_context.dart';
import 'package:fake_store/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:fake_store/src/res/app_fonts.dart';
import 'package:fake_store/src/res/app_svgs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:screendapt/screendapt.dart';

class LogOutButton extends StatelessWidget {
  const LogOutButton({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<AuthBloc>().logOut(),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: context.appTheme.accent,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(AppSvgs.logOut),
          ),
          SText(
            'Log out',
            style: TextStyle(
              fontSize: 14,
              fontFamily: AppFonts.lato,
            ),
          )
        ],
      ),
    );
  }
}
