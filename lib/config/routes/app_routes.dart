import 'package:bike_client_dealer/config/routes/app_pages.dart';
import 'package:bike_client_dealer/src/data/model/product_model.dart';
import 'package:bike_client_dealer/src/presentation/screens/favourite_screen.dart';
import 'package:bike_client_dealer/src/presentation/screens/home_screen.dart';
import 'package:bike_client_dealer/src/presentation/screens/product/all_product_screen.dart';
import 'package:bike_client_dealer/src/presentation/screens/product/product_details_screen.dart';
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
        path: Routes.productDetails,
        name: Routes.productDetails,
        builder: (context, state) => ProductDetailsScreen(
          product: state.extra as ProductModel,
        ),
      ),
      GoRoute(
        path: Routes.home,
        name: Routes.home,
        builder: (context, state) => const HomeScreen(),
        routes: [
          GoRoute(
            path: Routes.allProduct,
            name: Routes.allProduct,
            builder: (context, state) => const AllProductScreen(),
            routes: [
              GoRoute(
                path: Routes.favourite,
                name: Routes.favourite,
                builder: (context, state) => const FavouriteScreen(),
                routes: [],
              ),
            ],
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
