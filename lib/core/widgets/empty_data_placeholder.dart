import 'package:flutter/material.dart';

import '../utils/app_translations.dart';

class EmptyDataPlaceholder extends StatelessWidget {
  const EmptyDataPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Text(
        AppTranslations.t('common.no_data'),
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: colorScheme.onSurface.withValues(alpha: 0.5),
        ),
      ),
    );
  }
}
