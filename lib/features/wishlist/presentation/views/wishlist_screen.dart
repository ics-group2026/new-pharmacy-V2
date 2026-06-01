import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/widgets/product_card.dart';
import '../../../../../core/widgets/t_text.dart';
import '../../../flash_deals/data/models/flash_deal_model.dart';
import '../../cubit/wishlist_cubit.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const TText('nav_bar.wishlist')),
      body: BlocBuilder<WishlistCubit, List<FlashDealModel>>(
        builder: (_, items) => items.isEmpty
            ? const _EmptyState()
            : GridView.builder(
                padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 100.h),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12.w,
                  mainAxisSpacing: 12.h,
                  childAspectRatio: 0.65,
                ),
                itemCount: items.length,
                itemBuilder: (_, i) => ProductCard(product: items[i], imageHeight: 110.h),
              ),
      ),
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
