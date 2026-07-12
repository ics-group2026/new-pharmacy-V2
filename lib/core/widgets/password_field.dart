import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    this.onSaved,
    this.hintText,
    required this.controller,
    this.textInputType = TextInputType.text,
    this.validator,
  });
  final String? hintText;
  final Function(String?)? onSaved;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final String? Function(String?)? validator;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool isPasswordVisible = true;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextFormField(
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: () {
            isPasswordVisible = !isPasswordVisible;
            setState(() {});
          },
          icon: Icon(
            isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        hintText: widget.hintText,
      ),
      style: theme.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500, fontSize: 14),
      cursorColor: theme.colorScheme.primary,
      obscureText: isPasswordVisible,
      keyboardType: widget.textInputType,
      controller: widget.controller,
      validator:
          widget.validator ??
          (data) {
            if (data!.isEmpty) {
              return 'please_enter_field'.tr(namedArgs: {'field': widget.hintText ?? ''});
            }
            return null;
          },
      onSaved: widget.onSaved,
    );
  }
}
