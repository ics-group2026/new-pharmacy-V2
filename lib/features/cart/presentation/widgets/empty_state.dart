import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_pharamacy_theme_v1/core/utils/app_colors.dart';
import 'package:new_pharamacy_theme_v1/core/widgets/t_text.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

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
            child: Icon(Icons.shopping_cart_outlined, size: 48.r,
                color: colorScheme.primary.withValues(alpha: 0.6)),
          ),
          24.verticalSpace,
          TText('cart.empty_title',
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          10.verticalSpace,
          TText('cart.empty_subtitle',
              style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.5))),
        ],
      ),
    );
  }
}