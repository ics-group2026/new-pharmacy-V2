import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/validations.dart';

class PhoneField extends StatelessWidget {
  const PhoneField({
    super.key,
    this.onSaved,
    this.hintText,
    required this.controller,
    this.validator,
    this.enabled,
    this.autofocus = false,
  });

  final String? hintText;
  final Function(String?)? onSaved;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool? enabled;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextFormField(
      enabled: enabled,
      autofocus: autofocus,
      keyboardType: TextInputType.phone,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(11),
      ],
      decoration: InputDecoration(
        hintText: hintText?.tr(),
        prefixIcon: Icon(Icons.phone_outlined, color: theme.colorScheme.onSurfaceVariant),
      ),
      style: theme.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500, fontSize: 14),
      cursorColor: theme.colorScheme.primary,
      controller: controller,
      validator: validator ?? Validations.validatePhone,
      onSaved: onSaved,
    );
  }
}
