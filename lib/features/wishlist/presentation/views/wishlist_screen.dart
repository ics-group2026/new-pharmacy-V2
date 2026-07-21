import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/widgets/t_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Wishlist cubit was removed; the screen always shows the empty state
    // until the feature is rebuilt.
    return Scaffold(
      appBar: AppBar(title: const TText('nav_bar.wishlist')),
      body: const _EmptyState(),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

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
            decoration: BoxDecoration(color: AppColors.primaryContainer, shape: BoxShape.circle),
            child: Icon(Icons.favorite_border_rounded, size: 48.r,
                color: colorScheme.primary.withValues(alpha: 0.6)),
          ),
          24.verticalSpace,
          TText('wishlist.empty_title',
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          10.verticalSpace,
          TText('wishlist.empty_subtitle',
              style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.5))),
        ],
      ),
    );
  }
}
