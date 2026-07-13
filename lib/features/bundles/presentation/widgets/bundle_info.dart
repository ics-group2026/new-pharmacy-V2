import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/app_translations.dart';
import '../../../../core/widgets/discount_badge.dart';
import '../../data/models/bundle_model.dart';

class BundleInfo extends StatelessWidget {
  const BundleInfo({super.key, required this.bundle});

  final BundleModel bundle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final dateFormat = DateFormat('MMM d, yyyy');
    final currency = AppTranslations.t('flash_deals.currency');
    final hasDiscount = bundle.originalPrice > bundle.bundlePrice;
    final discountPercent = bundle.savingsPercentage.round();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                bundle.title,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
            ),
            if (hasDiscount && discountPercent > 0)
              DiscountBadge(percent: discountPercent),
          ],
        ),
        8.verticalSpace,
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              '${bundle.bundlePrice.toStringAsFixed(0)} $currency',
              style: theme.textTheme.titleLarge?.copyWith(
                color: colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (hasDiscount) ...[
              8.horizontalSpace,
              Text(
                '${bundle.originalPrice.toStringAsFixed(0)} $currency',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.5),
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ],
          ],
        ),
        if (hasDiscount) ...[
          8.verticalSpace,
          Text(
            '${AppTranslations.t('bundles.save')} '
            '${bundle.savings.toStringAsFixed(0)} $currency',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
        16.verticalSpace,
        Text(
          bundle.description,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurface.withValues(alpha: 0.75),
            height: 1.5,
          ),
        ),
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
              '${dateFormat.format(bundle.startDate)} - '
              '${dateFormat.format(bundle.endDate)}',
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
