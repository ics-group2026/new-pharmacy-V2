import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/data/repos/auth_repo.dart';
import '../../features/auth/presentation/cubits/auth_cubit.dart';
import '../../features/auth/presentation/views/login_screen.dart';
import '../../features/auth/presentation/views/register_screen.dart';
import '../../features/bundles/data/models/bundle_model.dart';
import '../../features/bundles/presentation/views/bundle_detail_screen.dart';
import '../../features/combo_offers/data/models/combo_offer_model.dart';
import '../../features/combo_offers/presentation/views/combo_offer_detail_screen.dart';
import '../../features/flash_deals/data/models/flash_deal_model.dart';
import '../../features/flash_deals/presentation/views/flash_deal_detail_screen.dart';
import '../../features/profile/presentation/cubits/profile_cubit.dart';
import '../../features/profile/presentation/views/profile_screen.dart';
import '../../features/nav_bar/presentation/views/bottom_nav_bar_screen.dart';
import '../../features/products/presentation/views/product_detail_screen.dart';
import '../../features/search/presentation/views/search_screen.dart';
import 'package:new_pharmacy_v2/core/models/static_product.dart';
import '../../features/notifications/presentation/views/notifications_screen.dart';
import '../constants/constants.dart';
import '../services/prefs.dart';
import '../services/setup_service_locator.dart';
import 'app_routes.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.login,
  redirect: (context, state) {
    final isLoggedIn = Prefs.getString(kToken) != null;
    final isOnAuthRoute =
        state.matchedLocation == AppRoutes.login ||
        state.matchedLocation == AppRoutes.register;

    if (isLoggedIn && isOnAuthRoute) return AppRoutes.navBar;
    return null;
  },
  errorBuilder: (context, state) =>
      Scaffold(body: Center(child: Text('No route found: ${state.uri}'))),
  routes: [
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => BlocProvider(
        create: (_) => AuthCubit(getIt<AuthRepo>()),
        child: const LoginScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.register,
      builder: (context, state) => BlocProvider(
        create: (_) => AuthCubit(getIt<AuthRepo>()),
        child: const RegisterScreen(),
      ),
    ),
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
      path: AppRoutes.profile,
      builder: (context, state) => BlocProvider.value(
        value: getIt<ProfileCubit>(),
        child: const ProfileScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.productDetail,
      builder: (context, state) {
        final product = state.extra as StaticProduct;
        return ProductDetailScreen(product: product);
      },
    ),
    GoRoute(
      path: AppRoutes.comboOfferDetail,
      builder: (context, state) {
        final comboOffer = state.extra as ComboOfferModel;
        return ComboOfferDetailScreen(comboOffer: comboOffer);
      },
    ),
    GoRoute(
      path: AppRoutes.flashDealDetail,
      builder: (context, state) {
        final flashDeal = state.extra as FlashDealModel;
        return FlashDealDetailScreen(flashDeal: flashDeal);
      },
    ),
    GoRoute(
      path: AppRoutes.bundleDetail,
      builder: (context, state) {
        final bundle = state.extra as BundleModel;
        return BundleDetailScreen(bundle: bundle);
      },
    ),
    GoRoute(
      path: AppRoutes.notifications,
      builder: (context, state) => const NotificationsScreen(),
    ),
  ],
);
