import 'package:flutter/material.dart';
import 'package:new_pharmacy_v2/core/widgets/t_text.dart';

class SettingsSectionTitle extends StatelessWidget {
  const SettingsSectionTitle({super.key, required this.titleKey});

  final String titleKey;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TText(
      titleKey,
      style: theme.textTheme.labelLarge?.copyWith(
        color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
        letterSpacing: 0.8,
      ),
    );
  }
}
