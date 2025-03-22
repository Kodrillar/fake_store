import 'dart:async';

import 'package:fake_store/src/features/auth/data/repository/auth.dart';
import 'package:fake_store/src/features/auth/presentation/screens/login.dart';
import 'package:fake_store/src/features/auth/presentation/screens/welcome.dart';
import 'package:fake_store/src/features/cart/presentation/screens/cart.dart';
import 'package:fake_store/src/features/home/domain/product.dart';
import 'package:fake_store/src/features/home/presentation/screens/home.dart';
import 'package:fake_store/src/features/home/presentation/screens/nav_home.dart';
import 'package:fake_store/src/features/home/presentation/screens/product_details.dart';
import 'package:fake_store/src/features/wish_list/presentation/screens/wish_list.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

typedef RedirectFunction = FutureOr<String?> Function(
    BuildContext, GoRouterState)?;

enum AppRoutes {
  welcome,
  login,
  navHome,
  home,
  productDetails,
  cart,
  wishList,
}

RedirectFunction get redirect => (context, state) {
      if (authStateChangesNotifier.value == null) {
        if (state.matchedLocation == '/${AppRoutes.login.name}') {
          return state.matchedLocation;
        }

        return '/';
      } else {
        if (state.matchedLocation != '/${AppRoutes.navHome.name}' &&
            state.matchedLocation != '/') {
          return state.matchedLocation;
        }
        return '/${AppRoutes.navHome.name}';
      }
    };

final GoRouter goRouter = GoRouter(
  initialLocation: '/${AppRoutes.navHome.name}',
  debugLogDiagnostics: true,
  redirect: redirect,
  refreshListenable: authStateChangesNotifier,
  routes: [
    GoRoute(
      path: '/',
      name: AppRoutes.welcome.name,
      builder: (context, state) => const WelcomeScreen(),
      routes: [
        GoRoute(
          path: AppRoutes.login.name,
          name: AppRoutes.login.name,
          builder: (context, state) => const LoginScreen(),
        )
      ],
    ),
    GoRoute(
      path: '/${AppRoutes.navHome.name}',
      name: AppRoutes.navHome.name,
      builder: (context, state) => const NavHomeView(),
      routes: [
        GoRoute(
          path: '/${AppRoutes.home.name}',
          name: AppRoutes.home.name,
          builder: (context, state) => const HomeScreen(),
          routes: [
            GoRoute(
              path: AppRoutes.productDetails.name,
              name: AppRoutes.productDetails.name,
              builder: (context, state) {
                final Product product = state.extra as Product;
                return ProductDetailsScreen(product: product);
              },
            ),
            GoRoute(
              path: AppRoutes.cart.name,
              name: AppRoutes.cart.name,
              builder: (context, state) => const CartScreen(),
            ),
            GoRoute(
              path: AppRoutes.wishList.name,
              name: AppRoutes.wishList.name,
              builder: (context, state) => const WishListScreen(),
            )
          ],
        )
      ],
    )
  ],
);
