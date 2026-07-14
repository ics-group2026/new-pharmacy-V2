import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_translations.dart';
import '../../data/models/flash_deal_model.dart';
import 'flash_deal_countdown.dart';

class FlashDealInfo extends StatelessWidget {
  const FlashDealInfo({super.key, required this.flashDeal});

  final FlashDealModel flashDeal;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final dateFormat = DateFormat('MMM d, yyyy');
    final description = flashDeal.description;
    final endsAt = flashDeal.endsAt;
    final startsAt = flashDeal.startsAt;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                flashDeal.title ?? '',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
            ),
          ],
        ),
        if (endsAt != null) ...[
          12.verticalSpace,
          Row(
            children: [
              Icon(Icons.bolt_rounded, size: 18.r, color: AppColors.flash),
              4.horizontalSpace,
              Text(
                AppTranslations.t('flash_deals.ends_in'),
                style: theme.textTheme.titleSmall?.copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.75),
                ),
              ),
              8.horizontalSpace,
              FlashDealCountdown(endsAt: endsAt),
            ],
          ),
        ],
        if (description != null && description.isNotEmpty) ...[
          16.verticalSpace,
          Text(
            description,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurface.withValues(alpha: 0.75),
              height: 1.5,
            ),
          ),
        ],
        if (startsAt != null && endsAt != null) ...[
          20.verticalSpace,
          Row(
            children: [
              Icon(
                Icons.event_available_rounded,
                size: 16.r,
                color: colorScheme.onSurfaceVariant,
              ),
              6.horizontalSpace,
              Text(
                '${dateFormat.format(startsAt.toLocal())} - '
                '${dateFormat.format(endsAt.toLocal())}',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
