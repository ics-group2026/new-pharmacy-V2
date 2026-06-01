import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/widgets/animated_fade_slide.dart';
import '../../../../../core/widgets/product_card.dart';
import '../../../../../core/widgets/t_text.dart';
import '../../../flash_deals/data/models/flash_deal_model.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  static const _items = [
    FlashDealModel(
      name: 'Aura Radiance Hydration Serum',
      price: 54.0,
      originalPrice: 72.0,
      discountPercent: 25,
      imageUrl: 'https://picsum.photos/seed/wl1/300/300',
      rating: 4.5,
    ),
    FlashDealModel(
      name: 'MEDIDERM Dermatological Moisturizer',
      price: 65.0,
      originalPrice: 85.0,
      discountPercent: 24,
      imageUrl: 'https://picsum.photos/seed/wl2/300/300',
      rating: 4.0,
    ),
    FlashDealModel(
      name: 'Vitamin C 1000mg Effervescent',
      price: 89.0,
      originalPrice: 115.0,
      discountPercent: 23,
      imageUrl: 'https://picsum.photos/seed/wl3/300/300',
      rating: 5.0,
    ),
    FlashDealModel(
      name: 'Biotin Hair Growth Formula',
      price: 120.0,
      originalPrice: 160.0,
      discountPercent: 25,
      imageUrl: 'https://picsum.photos/seed/wl4/300/300',
      rating: 4.0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const TText('nav_bar.wishlist')),
      body: _items.isEmpty
          ? _WishlistEmptyState()
          : AnimatedFadeSlide(
              delay: Duration.zero,
              child: GridView.builder(
                padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 100.h),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12.w,
                  mainAxisSpacing: 12.h,
                  childAspectRatio: 0.65,
                ),
                itemCount: _items.length,
                itemBuilder: (_, index) => ProductCard(
                  product: _items[index],
                  imageHeight: 110.h,
                ),
              ),
            ),
    );
  }
}

class _WishlistEmptyState extends StatelessWidget {
  const _WishlistEmptyState();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100.r,
            height: 100.r,
            decoration: BoxDecoration(
              color: AppColors.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.favorite_border_rounded,
              size: 48.r,
              color: colorScheme.primary.withValues(alpha: 0.6),
            ),
          ),
          24.verticalSpace,
          TText(
            'wishlist.empty_title',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          10.verticalSpace,
          TText(
            'wishlist.empty_subtitle',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurface.withValues(alpha: 0.5),
            ),
          ),
        ],
      ),
    );
  }
}
