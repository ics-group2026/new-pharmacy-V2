import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_pharmacy_v2/core/utils/app_translations.dart';
import 'package:new_pharmacy_v2/core/widgets/animated_fade_slide.dart';
import 'package:new_pharmacy_v2/core/widgets/pill_chip.dart';

const _popularSearchKeys = [
  'search.popular_item_1',
  'search.popular_item_2',
  'search.popular_item_3',
  'search.popular_item_4',
  'search.popular_item_5',
  'search.popular_item_6',
];

/// Shown before the user has typed anything: recent searches (with a clear
/// action) followed by a static list of popular searches.
class SearchIdleContent extends StatelessWidget {
  const SearchIdleContent({
    super.key,
    required this.recentSearches,
    required this.onSelect,
    required this.onClearRecent,
  });

  final List<String> recentSearches;
  final ValueChanged<String> onSelect;
  final VoidCallback onClearRecent;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (recentSearches.isNotEmpty) ...[
            AnimatedFadeSlide(
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      AppTranslations.t('search.recent_searches'),
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: onClearRecent,
                    child: Text(AppTranslations.t('search.clear_all')),
                  ),
                ],
              ),
            ),
            8.verticalSpace,
            AnimatedFadeSlide(
              delay: const Duration(milliseconds: 60),
              child: Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: [
                  for (final term in recentSearches)
                    PillChip(
                      label: term,
                      isSelected: false,
                      icon: Icons.history_rounded,
                      onTap: () => onSelect(term),
                    ),
                ],
              ),
            ),
            24.verticalSpace,
          ],
          AnimatedFadeSlide(
            delay: const Duration(milliseconds: 120),
            child: Text(
              AppTranslations.t('search.popular_searches'),
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          8.verticalSpace,
          AnimatedFadeSlide(
            delay: const Duration(milliseconds: 180),
            child: Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: [
                for (final key in _popularSearchKeys)
                  PillChip(
                    label: AppTranslations.t(key),
                    isSelected: false,
                    icon: Icons.trending_up_rounded,
                    onTap: () => onSelect(AppTranslations.t(key)),
                  ),
              ],
            ),
          ),
          32.verticalSpace,
          AnimatedFadeSlide(
            delay: const Duration(milliseconds: 220),
            child: Center(
              child: Column(
                children: [
                  Icon(
                    Icons.search_rounded,
                    size: 64.r,
                    color: colorScheme.onSurface.withValues(alpha: 0.12),
                  ),
                  16.verticalSpace,
                  Text(
                    AppTranslations.t('search.empty_title'),
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  8.verticalSpace,
                  Text(
                    AppTranslations.t('search.empty_subtitle'),
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
