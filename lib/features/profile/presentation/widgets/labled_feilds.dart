import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_pharmacy_v2/core/utils/app_translations.dart';
import 'package:new_pharmacy_v2/core/widgets/custom_text_form_field.dart';
import 'package:new_pharmacy_v2/core/widgets/t_text.dart';

class LabeledField extends StatelessWidget {
  const LabeledField({super.key, 
    required this.labelKey,
    required this.controller,
    required this.hintKey,
    required this.icon,
    required this.validator,
    this.keyboardType = TextInputType.text,
  });

  final String labelKey;
  final TextEditingController controller;
  final String hintKey;
  final IconData icon;
  final String? Function(String?) validator;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TText(
          labelKey,
          style: theme.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        CustomTextFormField(
          controller: controller,
          hintText: AppTranslations.t(hintKey),
          textInputType: keyboardType,
          prefixIcon: Icon(icon, color: theme.colorScheme.onSurfaceVariant),
          validator: validator,
        ),
      ],
    );
  }
}