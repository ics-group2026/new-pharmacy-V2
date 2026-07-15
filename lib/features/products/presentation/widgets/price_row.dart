import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_pharmacy_v2/core/utils/app_colors.dart';
import 'package:new_pharmacy_v2/core/utils/app_translations.dart';
import 'package:new_pharmacy_v2/features/products/data/models/product_model.dart';

class PriceRow extends StatelessWidget {
  const PriceRow({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final currency = AppTranslations.t('flash_deals.currency');

    final price = product.sellingPrice ?? product.price ?? 0;
    final originalPrice = product.hasDiscount ? product.price : null;
    final discountPercent = product.discountPercent;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.primaryContainer,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '${price.toStringAsFixed(0)} $currency',
            style: theme.textTheme.headlineSmall?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (originalPrice != null) ...[
            12.horizontalSpace,
            Padding(
              padding: EdgeInsets.only(bottom: 2.h),
              child: Text(
                '${originalPrice.toStringAsFixed(0)} $currency',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.4),
                  decoration: TextDecoration.lineThrough,
                  decorationColor: colorScheme.onSurface.withValues(alpha: 0.4),
                ),
              ),
            ),
          ],
          const Spacer(),
          if (discountPercent != null)
            Text(
              'Save $discountPercent%',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: colorScheme.primary,
              ),
            ),
        ],
      ),
    );
  }
}