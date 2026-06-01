import 'package:flutter/material.dart';

import '../../../../../core/widgets/t_text.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.labelKey,
    required this.icon,
    required this.backgroundColor,
    required this.iconColor,
    this.onTap,
  });

  final String labelKey;
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.sizeOf(context);
    final itemWidth = size.width * 0.19;
    final circleSize = itemWidth * 0.85;
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: itemWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: circleSize,
              height: circleSize,
              decoration: BoxDecoration(
                color: isDark
                    ? backgroundColor.withValues(alpha: 0.15)
                    : backgroundColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: isDark ? backgroundColor : iconColor,
                size: circleSize * 0.46,
              ),
            ),
            SizedBox(height: size.height * 0.008),
            TText(
              labelKey,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.w500,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
