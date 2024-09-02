import 'package:bike_client_dealer/config/routes/app_pages.dart';
import 'package:bike_client_dealer/src/presentation/screens/home_screen.dart';
import 'package:bike_client_dealer/src/presentation/screens/product/all_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static final rootNavigatorKey = GlobalKey<NavigatorState>();
  static GoRouter router = GoRouter(
    initialLocation: Routes.home,
    debugLogDiagnostics: true,
    navigatorKey: rootNavigatorKey,
    routes: [
      GoRoute(
        path: Routes.home,
        name: Routes.home,
        builder: (context, state) => const HomeScreen(),
        routes: [
          GoRoute(
            path: Routes.allProduct,
            name: Routes.allProduct,
            builder: (context, state) => const AllProductScreen(),
          ),
        ],
      ),
    ],
  );
}

class TalyaNonAuthRoute extends GoRoute {
  TalyaNonAuthRoute({
    required String path,
    required Widget Function(BuildContext, GoRouterState) builder,
  }) : super(
          path: path,
          builder: builder,
        );
}

class TalyaAuthRoute extends GoRoute {
  final bool Function(BuildContext) isAuthenticated;

  TalyaAuthRoute({
    required String path,
    required Widget Function(BuildContext, GoRouterState) builder,
    required this.isAuthenticated,
  }) : super(
          path: path,
          builder: builder,
          redirect: (context, state) {
            if (!isAuthenticated(context)) {
              return '/signIn'; // Redirect to sign-in if not authenticated
            }
            return null; // Allow navigation if authenticated
          },
        );
}
