import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:new_pharmacy_v2/core/utils/app_colors.dart';
import 'package:new_pharmacy_v2/core/utils/app_translations.dart';
import 'package:new_pharmacy_v2/core/widgets/animated_fade_slide.dart';
import 'package:new_pharmacy_v2/core/widgets/discount_badge.dart';
import 'package:new_pharmacy_v2/core/widgets/star_rating_row.dart';
import 'package:new_pharmacy_v2/features/products/data/models/product_model.dart';
import 'price_row.dart';

class ProductHeader extends StatelessWidget {
  const ProductHeader({super.key, required this.product, this.rating});

  final ProductModel product;

  /// Average rating from the details endpoint; null hides the stars (the list
  /// payload carries no rating).
  final double? rating;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final discountPercent = product.discountPercent;

    return AnimatedFadeSlide(
      delay: Duration.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (discountPercent != null)
                DiscountBadge(percent: discountPercent),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.primaryContainer,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.inventory_2_outlined, size: 13.r, color: colorScheme.primary),
                    4.horizontalSpace,
                    Text(
                      AppTranslations.t('product_detail.in_stock'),
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          12.verticalSpace,
          Text(
            product.name ?? '',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
              height: 1.3,
            ),
          ),
          if (rating != null) ...[
            10.verticalSpace,
            Row(
              children: [
                StarRatingRow(rating: rating!, size: 16.r),
                10.horizontalSpace,
                Text(
                  '(128 ${AppTranslations.t('product_detail.reviews')})',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                ),
              ],
            ),
          ],
          16.verticalSpace,
          PriceRow(product: product),
        ],
      ),
    );
  }
}
