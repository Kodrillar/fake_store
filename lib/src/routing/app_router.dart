import 'package:fake_store/src/features/auth/presentation/screens/login.dart';
import 'package:fake_store/src/features/auth/presentation/screens/welcome.dart';
import 'package:fake_store/src/features/home/presentation/screens/home.dart';
import 'package:go_router/go_router.dart';

enum AppRoutes {
  welcome,
  login,
  home,
  productDetails,
}

final GoRouter goRouter = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
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
      path: '/${AppRoutes.home.name}',
      name: AppRoutes.home.name,
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: AppRoutes.productDetails.name,
          name: AppRoutes.productDetails.name,
          builder: (context, state) => const ProductCardDetails(),
        )
      ],
    )
  ],
);
