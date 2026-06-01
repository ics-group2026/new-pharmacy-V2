import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_pharamacy_theme_v1/core/widgets/animated_fade_slide.dart';
import 'package:new_pharamacy_theme_v1/core/widgets/section_header.dart';

class HowToUseWidget extends StatelessWidget {
  const HowToUseWidget({
    super.key,
    required this.colorScheme,
    required this.theme,
  });
  final ColorScheme colorScheme;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return AnimatedFadeSlide(
      delay: const Duration(milliseconds: 180),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(titleKey: 'product_detail.how_to_use'),
          12.verticalSpace,
          Text(
            'Take one unit daily with a full glass of water, preferably with a meal. '
            'Do not exceed the recommended dosage. '
            'Consult your physician before use if you have any medical conditions.',
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
