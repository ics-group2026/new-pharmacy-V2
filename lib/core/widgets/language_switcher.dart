import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 't_text.dart';

class LanguageSwitcher extends StatelessWidget {
  const LanguageSwitcher({super.key});

  static const _languages = [
    (code: 'en', label: 'language.english', flag: '🇺🇸'),
    (code: 'ar', label: 'language.arabic', flag: '🇸🇦'),
  ];

  void _show(BuildContext context) {
    final theme = Theme.of(context);
    showModalBottomSheet(
      context: context,
      backgroundColor: theme.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(theme.cardTheme.shape is RoundedRectangleBorder
              ? (theme.cardTheme.shape as RoundedRectangleBorder)
                  .borderRadius
                  .resolve(null)
                  .topLeft
                  .x
              : 20),
        ),
      ),
      builder: (_) => _LanguageSheet(currentLocale: context.locale),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => _show(context),
      leading: const Icon(Icons.language_rounded),
      title: const TText('language.select_language'),
      trailing: const Icon(Icons.chevron_right_rounded),
    );
  }
}

class _LanguageSheet extends StatelessWidget {
  const _LanguageSheet({required this.currentLocale});

  final Locale currentLocale;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: colorScheme.outlineVariant,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8, left: 16, right: 16),
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: TText(
                  'language.select_language',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: colorScheme.onSurface,
                  ),
                ),
              ),
            ),
            const Divider(height: 1),
            for (final lang in LanguageSwitcher._languages)
              _LanguageTile(
                flag: lang.flag,
                labelKey: lang.label,
                isSelected: currentLocale.languageCode == lang.code,
                onTap: () {
                  context.setLocale(Locale(lang.code));
                  Navigator.pop(context);
                },
                colorScheme: colorScheme,
                textTheme: theme.textTheme,
              ),
          ],
        ),
      ),
    );
  }
}

class _LanguageTile extends StatelessWidget {
  const _LanguageTile({
    required this.flag,
    required this.labelKey,
    required this.isSelected,
    required this.onTap,
    required this.colorScheme,
    required this.textTheme,
  });

  final String flag;
  final String labelKey;
  final bool isSelected;
  final VoidCallback onTap;
  final ColorScheme colorScheme;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Text(flag, style: textTheme.titleLarge),
      title: TText(
        labelKey,
        style: textTheme.bodyLarge?.copyWith(
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          color: isSelected ? colorScheme.primary : colorScheme.onSurface,
        ),
      ),
      trailing: isSelected
          ? Icon(Icons.check_circle_rounded, color: colorScheme.primary)
          : null,
    );
  }
}
