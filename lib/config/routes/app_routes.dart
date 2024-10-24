import 'package:bike_client_dealer/config/routes/app_pages.dart';
import 'package:bike_client_dealer/src/data/model/category_model%20copy.dart';
import 'package:bike_client_dealer/src/data/model/company_model.dart';
import 'package:bike_client_dealer/src/data/model/product_model.dart';
import 'package:bike_client_dealer/src/presentation/screens/chats/chat_screen.dart';
import 'package:bike_client_dealer/src/presentation/screens/favourite_screen.dart';
import 'package:bike_client_dealer/src/presentation/screens/home_screen.dart';
import 'package:bike_client_dealer/src/presentation/screens/listen_product_screen.dart';
import 'package:bike_client_dealer/src/presentation/screens/order_screen.dart';
import 'package:bike_client_dealer/src/presentation/screens/product/all_product_screen.dart';
import 'package:bike_client_dealer/src/presentation/screens/product/product_details_screen.dart';
import 'package:bike_client_dealer/src/presentation/screens/profile/profile_screen.dart';
import 'package:bike_client_dealer/src/presentation/screens/sell/sell_screen.dart';
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
          product: state.extra is ProductModel ? state.extra as ProductModel : null,
          id: state.extra is String ? state.extra as String : null,
        ),
      ),
      GoRoute(
        path: Routes.chats,
        name: Routes.chats,
        builder: (context, state) => ChatScreen(
          productModel: state.extra is ProductModel ? state.extra as ProductModel : null,
        ),
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
                path: Routes.order,
                name: Routes.order,
                builder: (context, state) => const OrderScreen(),
              ),
              GoRoute(
                path: Routes.transaction,
                name: Routes.transaction,
                builder: (context, state) => const TransactionScreen(),
              ),
              GoRoute(
                path: Routes.sell,
                name: Routes.sell,
                builder: (context, state) => const SellScreen(),
              ),
              GoRoute(
                path: Routes.listenProductScreen,
                name: Routes.listenProductScreen,
                builder: (context, state) => const ListenProductScreen(),
              ),
            ],
          ),
          GoRoute(
            path: Routes.allProduct,
            name: Routes.allProduct,
            builder: (context, state) {
              return AllProductScreen(
                fromSelecting: state.extra is bool ? state.extra as bool : false,
                products: state.extra is List<String> ? state.extra as List<String> : null,
                selectedCategory: state.extra is CategoryModel ? state.extra as CategoryModel : null,
                selectedCompany: state.extra is CompanyModel ? state.extra as CompanyModel : null,
              );
            },
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
