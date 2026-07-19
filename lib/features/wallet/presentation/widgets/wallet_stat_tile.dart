import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/t_text.dart';

/// A single stat inside the gradient balance card. Always renders on the brand
/// gradient, so its colours are intentionally white rather than theme tokens.
class WalletStatTile extends StatelessWidget {
  const WalletStatTile({
    super.key,
    required this.icon,
    required this.labelKey,
    required this.value,
  });

  final IconData icon;
  final String labelKey;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18.r, color: Colors.white.withValues(alpha: 0.85)),
        8.horizontalSpace,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TText(
              labelKey,
              style: theme.textTheme.labelSmall?.copyWith(
                color: Colors.white.withValues(alpha: 0.75),
              ),
            ),
            2.verticalSpace,
            Text(
              value,
              style: theme.textTheme.titleMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
