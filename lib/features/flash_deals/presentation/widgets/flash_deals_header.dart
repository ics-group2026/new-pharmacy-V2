import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_translations.dart';
import 'flash_deal_countdown.dart';

class FlashDealsHeader extends StatelessWidget {
  const FlashDealsHeader({super.key, this.soonestEndsAt});

  /// End time of the deal expiring first — drives the headline countdown.
  final DateTime? soonestEndsAt;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final endsAt = soonestEndsAt;

    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(6.r),
          decoration: BoxDecoration(
            color: AppColors.flash.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(Icons.bolt_rounded, color: AppColors.flash, size: 20.r),
        ),
        8.horizontalSpace,
        Expanded(
          child: Text(
            AppTranslations.t('flash_deals.title'),
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
        ),
        if (endsAt != null) ...[
          Text(
            AppTranslations.t('flash_deals.ends_in'),
            style: theme.textTheme.labelSmall?.copyWith(
              color: colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
          6.horizontalSpace,
          FlashDealCountdown(endsAt: endsAt),
        ],
      ],
    );
  }
}
