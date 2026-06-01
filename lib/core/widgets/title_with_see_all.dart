import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_translations.dart';
import 't_text.dart';

class TitleWithSeeAll extends StatelessWidget {
  const TitleWithSeeAll({super.key, required this.titleKey, required this.onSeeAll});

  final String titleKey;
  final VoidCallback onSeeAll;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TText(
          titleKey,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        GestureDetector(
          onTap: onSeeAll,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppTranslations.t('common.see_all'),
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              3.horizontalSpace,
              Icon(Icons.arrow_forward_ios_rounded, size: 12.r, color: colorScheme.primary),
            ],
          ),
        ),
      ],
    );
  }
}
