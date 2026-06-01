import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/nav_bar/presentation/views/bottom_nav_bar_screen.dart';
import '../../features/products/presentation/views/product_detail_screen.dart';
import '../../features/search/presentation/views/search_screen.dart';
import '../../features/flash_deals/data/models/flash_deal_model.dart';
import 'app_routes.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.navBar,
  // redirect: (context, state) {
  //   final isLoggedIn = Prefs.getString(kToken) != null;
  //   final isOnLogin = state.matchedLocation == AppRoutes.login;

  //   if (!isLoggedIn && !isOnLogin) return AppRoutes.login;
  //   return null;
  // },
  errorBuilder: (context, state) =>
      Scaffold(body: Center(child: Text('No route found: ${state.uri}'))),
  routes: [
    GoRoute(path: AppRoutes.login, builder: (context, state) => const Scaffold()),
    GoRoute(path: AppRoutes.home, builder: (context, state) => const Scaffold()),
    GoRoute(
      path: AppRoutes.navBar,
      builder: (context, state) => const BottomNavBarScreen(),
    ),
    GoRoute(
      path: AppRoutes.search,
      builder: (context, state) => const SearchScreen(),
    ),
    GoRoute(
      path: AppRoutes.productDetail,
      builder: (context, state) {
        final product = state.extra as FlashDealModel;
        return ProductDetailScreen(product: product);
      },
    ),
  ],
);
