import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_translations.dart';
import '../../../account/presentation/views/account_screen.dart';
import '../../../cart/presentation/views/cart_screen.dart';
import '../../../home/presentation/views/home_screen.dart';
import '../../../wishlist/presentation/views/wishlist_screen.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key});

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int _currentIndex = 0;

  static const List<Widget> _screens = [
    HomeScreen(),
    WishlistScreen(),
    CartScreen(),
    AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return PopScope(
      canPop: _currentIndex == 0,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) setState(() => _currentIndex = 0);
      },
      child: Scaffold(
        body: _screens[_currentIndex],
        bottomNavigationBar: NavigationBar(
          elevation: 0,
          selectedIndex: _currentIndex,
          onDestinationSelected: (index) => setState(() => _currentIndex = index),
          backgroundColor: theme.navigationBarTheme.backgroundColor,
          indicatorColor: colorScheme.primaryContainer,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          destinations: [
            _buildDestination(
              icon: Icons.home_outlined,
              selectedIcon: Icons.home_rounded,
              labelKey: 'nav_bar.home',
              isSelected: _currentIndex == 0,
              colorScheme: colorScheme,
            ),
            _buildDestination(
              icon: Icons.favorite_border_rounded,
              selectedIcon: Icons.favorite_rounded,
              labelKey: 'nav_bar.wishlist',
              isSelected: _currentIndex == 1,
              colorScheme: colorScheme,
            ),
            _buildDestination(
              icon: Icons.shopping_cart_outlined,
              selectedIcon: Icons.shopping_cart_rounded,
              labelKey: 'nav_bar.cart',
              isSelected: _currentIndex == 2,
              colorScheme: colorScheme,
            ),
            _buildDestination(
              icon: Icons.person_outline_rounded,
              selectedIcon: Icons.person_rounded,
              labelKey: 'nav_bar.account',
              isSelected: _currentIndex == 3,
              colorScheme: colorScheme,
            ),
          ],
        ),
      ),
    );
  }

  NavigationDestination _buildDestination({
    required IconData icon,
    required IconData selectedIcon,
    required String labelKey,
    required bool isSelected,
    required ColorScheme colorScheme,
  }) {
    return NavigationDestination(
      icon: Icon(icon, color: AppColors.greyColor),
      selectedIcon: Icon(selectedIcon, color: colorScheme.primary),
      label: AppTranslations.t(labelKey),
    );
  }
}
