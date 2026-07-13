import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_translations.dart';

class ComboOffersHeader extends StatelessWidget {
  const ComboOffersHeader({super.key});

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
      ],
    );
  }
}
