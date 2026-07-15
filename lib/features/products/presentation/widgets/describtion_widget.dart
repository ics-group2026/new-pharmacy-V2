import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_pharmacy_v2/core/widgets/animated_fade_slide.dart';
import 'package:new_pharmacy_v2/core/widgets/section_header.dart';

class DescriptionWidget extends StatelessWidget {
  const DescriptionWidget({
    super.key,
    required this.colorScheme,
    required this.theme,
    this.description,
  });
  final ColorScheme colorScheme;
  final ThemeData theme;

  /// The product's description, possibly HTML. Falls back to placeholder copy
  /// when null or empty (e.g. the hardcoded demo products).
  final String? description;

  static const _placeholder =
      'A premium quality product formulated to support your health and wellness. '
      'Made with carefully selected ingredients that meet the highest safety standards. '
      'Suitable for daily use and recommended by healthcare professionals.';

  @override
  Widget build(BuildContext context) {
    final plain = _stripHtml(description);
    return AnimatedFadeSlide(
      delay: const Duration(milliseconds: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(titleKey: 'product_detail.description'),
          12.verticalSpace,
          Text(
            plain.isEmpty ? _placeholder : plain,
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

/// Reduces API HTML (e.g. `<p>…</p>`) to plain text — the app has no HTML
/// renderer, and the description is short prose.
String _stripHtml(String? input) {
  if (input == null) return '';
  return input
      .replaceAll(RegExp(r'<[^>]*>'), ' ')
      .replaceAll('&nbsp;', ' ')
      .replaceAll(RegExp(r'\s+'), ' ')
      .trim();
}
