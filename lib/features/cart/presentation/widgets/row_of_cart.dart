import 'package:flutter/material.dart';
import 'package:new_pharamacy_theme_v1/core/widgets/t_text.dart';

class RowOfCart extends StatelessWidget {
  const RowOfCart({super.key, required this.labelKey, this.value, this.valueKey, this.bold = false, this.valueColor});

  final String labelKey;
  final String? value;
  final String? valueKey;
  final bool bold;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodyMedium?.copyWith(
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
      color: bold ? Theme.of(context).colorScheme.primary : null,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TText(labelKey, style: style),
        valueKey != null
            ? TText(valueKey!, style: style?.copyWith(color: valueColor))
            : Text(value ?? '', style: style?.copyWith(color: valueColor)),
      ],
    );
  }
}