import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_translations.dart';

class ComboOffersHeader extends StatelessWidget {
  const ComboOffersHeader({super.key, this.onSeeAll});

  final VoidCallback? onSeeAll;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(6.r),
          decoration: BoxDecoration(
            color: const Color(0xFFFFC107).withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(
            Icons.card_giftcard_rounded,
            color: const Color(0xFFFFC107),
            size: 20.r,
          ),
        ),
        8.horizontalSpace,
        Expanded(
          child: Text(
            AppTranslations.t('combo_offers.title'),
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
        ),
        GestureDetector(
          onTap: onSeeAll ?? () {},
          child: Row(
            children: [
              Text(
                AppTranslations.t('common.see_all'),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              2.horizontalSpace,
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 11.r,
                color: colorScheme.primary,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
