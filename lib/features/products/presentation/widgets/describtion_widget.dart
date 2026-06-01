import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_pharamacy_theme_v1/core/widgets/animated_fade_slide.dart';
import 'package:new_pharamacy_theme_v1/core/widgets/section_header.dart';

class DescriptionWidget extends StatelessWidget {
  const DescriptionWidget({super.key, required this.colorScheme, required this.theme});
  final ColorScheme colorScheme;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return AnimatedFadeSlide(
      delay: const Duration(milliseconds: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(titleKey: 'product_detail.description'),
          12.verticalSpace,
          Text(
            'A premium quality product formulated to support your health and wellness. '
            'Made with carefully selected ingredients that meet the highest safety standards. '
            'Suitable for daily use and recommended by healthcare professionals.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurface.withValues(alpha: 0.65),
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
