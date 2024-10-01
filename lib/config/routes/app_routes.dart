import 'package:bike_client_dealer/config/routes/app_pages.dart';
import 'package:bike_client_dealer/src/data/model/product_model.dart';
import 'package:bike_client_dealer/src/presentation/screens/chats/chat_screen.dart';
import 'package:bike_client_dealer/src/presentation/screens/favourite_screen.dart';
import 'package:bike_client_dealer/src/presentation/screens/home_screen.dart';
import 'package:bike_client_dealer/src/presentation/screens/product/all_product_screen.dart';
import 'package:bike_client_dealer/src/presentation/screens/product/product_details_screen.dart';
import 'package:bike_client_dealer/src/presentation/screens/profile/profile_screen.dart';
import 'package:bike_client_dealer/src/presentation/screens/transaction/transaction_screen.dart';
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
          product:
              state.extra is ProductModel ? state.extra as ProductModel : null,
          id: state.extra is String ? state.extra as String : null,
        ),
      ),
      GoRoute(
        path: Routes.chats,
        name: Routes.chats,
        builder: (context, state) => const ChatScreen(),
      ),
      GoRoute(
        path: Routes.home,
        name: Routes.home,
        builder: (context, state) => const HomeScreen(),
        routes: [
          GoRoute(
            path: Routes.profile,
            name: Routes.profile,
            builder: (context, state) => const ProfileScreen(),
            routes: [
              GoRoute(
                path: Routes.transaction,
                name: Routes.transaction,
                builder: (context, state) => const TransactionScreen(),
              ),
            ],
          ),
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
