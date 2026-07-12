import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/services/setup_service_locator.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_translations.dart';
import '../../../account/presentation/views/account_screen.dart';
import '../../../cart/presentation/views/cart_screen.dart';
import '../../../home/presentation/views/home_screen.dart';
import '../../../profile/presentation/cubits/profile_cubit.dart';
import '../../../wishlist/presentation/views/wishlist_screen.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key});

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int _currentIndex = 0;
  final _profileCubit = getIt<ProfileCubit>();

  @override
  void initState() {
    super.initState();
    _profileCubit.getProfile();
  }

  static const List<Widget> _screens = [
    HomeScreen(),
    WishlistScreen(),
    CartScreen(),
    AccountScreen(),
  ];

  static const _navItems = [
    _NavItem(Icons.home_outlined, Icons.home_rounded, 'nav_bar.home'),
    _NavItem(
      Icons.favorite_border_rounded,
      Icons.favorite_rounded,
      'nav_bar.wishlist',
    ),
    _NavItem(
      Icons.shopping_cart_outlined,
      Icons.shopping_cart_rounded,
      'nav_bar.cart',
    ),
    _NavItem(
      Icons.person_outline_rounded,
      Icons.person_rounded,
      'nav_bar.account',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _profileCubit,
      child: PopScope(
        canPop: _currentIndex == 0,
        onPopInvokedWithResult: (didPop, _) {
          if (!didPop) setState(() => _currentIndex = 0);
        },
        child: Scaffold(
          body: Stack(
            children: [
              IndexedStack(index: _currentIndex, children: _screens),
              Positioned(
                bottom: 16.h,
                left: 16.w,
                right: 16.w,
                child: _FloatingNavBar(
                  currentIndex: _currentIndex,
                  items: _navItems,
                  onTap: (index) => setState(() => _currentIndex = index),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FloatingNavBar extends StatelessWidget {
  const _FloatingNavBar({
    required this.currentIndex,
    required this.items,
    required this.onTap,
  });

  final int currentIndex;
  final List<_NavItem> items;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(28.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (index) {
          final item = items[index];
          final isSelected = currentIndex == index;
          return _NavBarItem(
            icon: item.icon,
            selectedIcon: item.selectedIcon,
            label: AppTranslations.t(item.labelKey),
            isSelected: isSelected,
            onTap: () => onTap(index),
          );
        }),
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  const _NavBarItem({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? colorScheme.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? selectedIcon : icon,
              size: 22.r,
              color: isSelected ? Colors.white : AppColors.greyColor,
            ),
            if (isSelected) ...[
              6.horizontalSpace,
              Text(
                label,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _NavItem {
  const _NavItem(this.icon, this.selectedIcon, this.labelKey);

  final IconData icon;
  final IconData selectedIcon;
  final String labelKey;
}
