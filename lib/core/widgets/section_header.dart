import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_translations.dart';
import 't_text.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.titleKey,
    this.onSeeAll,
    this.accentColor,
  });

  final String titleKey;
  final VoidCallback? onSeeAll;
  final Color? accentColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final accent = accentColor ?? colorScheme.primary;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 4.w,
          height: 22.h,
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),
        10.horizontalSpace,
        Expanded(
          child: TText(
            titleKey,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
        ),
        if (onSeeAll != null)
          GestureDetector(
            onTap: onSeeAll,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppTranslations.t('common.see_all'),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: accent,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                2.horizontalSpace,
                Icon(Icons.arrow_forward_ios_rounded, size: 11.r, color: accent),
              ],
            ),
          ),
      ],
    );
  }
}
