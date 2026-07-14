import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_pharmacy_v2/core/utils/app_colors.dart';
import 'package:new_pharmacy_v2/core/utils/app_translations.dart';
import 'package:new_pharmacy_v2/core/models/static_product.dart';

class PriceRow extends StatelessWidget {
  const PriceRow({super.key, required this.product});

  final StaticProduct product;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final currency = AppTranslations.t('flash_deals.currency');

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
            '${product.price.toStringAsFixed(0)} $currency',
            style: theme.textTheme.headlineSmall?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (product.originalPrice != null) ...[
            12.horizontalSpace,
            Padding(
              padding: EdgeInsets.only(bottom: 2.h),
              child: Text(
                '${product.originalPrice!.toStringAsFixed(0)} $currency',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.4),
                  decoration: TextDecoration.lineThrough,
                  decorationColor: colorScheme.onSurface.withValues(alpha: 0.4),
                ),
              ),
            ),
          ],
          const Spacer(),
          if (product.discountPercent != null)
            Text(
              'Save ${((1 - product.price / product.originalPrice!) * 100).toStringAsFixed(0)}%',
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