import 'package:flutter/material.dart';

import '../utils/app_translations.dart';

class EmptyDataPlaceholder extends StatelessWidget {
  const EmptyDataPlaceholder({super.key, this.messageKey = 'common.no_data'});

  /// Translation key for the empty message. Defaults to the generic
  /// `common.no_data`; override for a context-specific message.
  final String messageKey;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Text(
        AppTranslations.t(messageKey),
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: colorScheme.onSurface.withValues(alpha: 0.5),
        ),
      ),
    );
  }
}
