import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../core/widgets/discount_badge.dart';
import '../../data/models/combo_offer_model.dart';

class ComboOfferInfo extends StatelessWidget {
  const ComboOfferInfo({super.key, required this.comboOffer});

  final ComboOfferModel comboOffer;

  int? get _discountPercent {
    final buyQuantity = comboOffer.buyQuantity ?? 0;
    final payQuantity = comboOffer.payQuantity ?? 0;
    if (buyQuantity <= 0 || payQuantity >= buyQuantity) {
      return null;
    }
    return (((buyQuantity - payQuantity) / buyQuantity) * 100).round();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final discountPercent = _discountPercent;
    final dateFormat = DateFormat('MMM d, yyyy');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                comboOffer.title ?? '',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
            ),
            if (discountPercent != null) DiscountBadge(percent: discountPercent),
          ],
        ),
        8.verticalSpace,
        Text(
          comboOffer.offerDetails ?? '',
          style: theme.textTheme.titleMedium?.copyWith(
            color: colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        16.verticalSpace,
        Text(
          comboOffer.description ?? '',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurface.withValues(alpha: 0.75),
            height: 1.5,
          ),
        ),
        if (comboOffer.startDate != null && comboOffer.endDate != null) ...[
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
                '${dateFormat.format(comboOffer.startDate!)} - '
                '${dateFormat.format(comboOffer.endDate!)}',
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
