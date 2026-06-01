import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_pharamacy_theme_v1/core/utils/app_translations.dart';

class AddToCartBar extends StatelessWidget {
  const AddToCartBar({super.key, 
    required this.totalPrice,
    required this.currency,
    required this.onAddToCart,
  });

  final double totalPrice;
  final String currency;
  final VoidCallback onAddToCart;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 12.h),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppTranslations.t('product_detail.total'),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                ),
                4.verticalSpace,
                Text(
                  '${totalPrice.toStringAsFixed(0)} $currency',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                  ),
                ),
              ],
            ),
            16.horizontalSpace,
            Expanded(
              child: SizedBox(
                height: 48.h,
                child: ElevatedButton(
                  onPressed: onAddToCart,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
                  ),
                  child: Text(
                    AppTranslations.t('product_detail.add_to_cart'),
                    style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}