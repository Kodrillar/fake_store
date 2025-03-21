import 'package:fake_store/src/features/auth/bloc/auth_bloc.dart';
import 'package:fake_store/src/features/auth/data/repository/auth.dart';
import 'package:fake_store/src/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:fake_store/src/features/home/presentation/cubit/home_cubit.dart';
import 'package:fake_store/src/routing/app_router.dart';
import 'package:fake_store/src/theme/app_theme.dart';
import 'package:fake_store/src/theme/app_theme_data.dart';
import 'package:fake_store/src/theme/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screendapt/screendapt.dart';

class FakeStoreApp extends StatelessWidget {
  const FakeStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppTheme(
      theme: FakeStoreLight(),
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, _) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => AuthBloc()),
              BlocProvider(create: (context) => HomeCubit()),
              BlocProvider(create: (context) => CartCubit()),
            ],
            child: ValueListenableBuilder(
                valueListenable: authStateChangesNotifier,
                builder: (context, authState, _) {
                  return MaterialApp.router(
                    debugShowCheckedModeBanner: false,
                    title: 'Flutter Demo',
                    theme: AppThemeData.getThemeData(context),
                    routerConfig: getGoRouter(
                      authState == null ? '/' : '/${AppRoutes.navHome.name}',
                    ),
                  );
                }),
          );
        },
      ),
    );
  }
}
