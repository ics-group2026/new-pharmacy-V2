import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_pharmacy_v2/core/utils/app_colors.dart';
import 'package:new_pharmacy_v2/core/utils/app_translations.dart';
import 'package:new_pharmacy_v2/core/widgets/password_field.dart';
import 'package:new_pharmacy_v2/core/widgets/t_text.dart';

/// Asks the user to re-enter their password. Pops with the entered password,
/// or with `null` if the user cancels.
class DeleteAccountDialog extends StatefulWidget {
  const DeleteAccountDialog({super.key});

  @override
  State<DeleteAccountDialog> createState() => _DeleteAccountDialogState();
}

class _DeleteAccountDialogState extends State<DeleteAccountDialog> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.pop(context, _passwordController.text);
  }

  String? _validatePassword(String? value) =>
      (value == null || value.isEmpty)
      ? AppTranslations.t('auth.validation.password_required')
      : null;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      title: TText('account.delete_account_confirm_title'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TText(
              'account.delete_account_confirm_message',
              style: theme.textTheme.bodyMedium,
            ),
            16.verticalSpace,
            PasswordField(
              controller: _passwordController,
              hintText: AppTranslations.t('auth.password_hint'),
              validator: _validatePassword,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: TText('common.cancel'),
        ),
        TextButton(
          onPressed: _submit,
          child: TText(
            'account.delete_account',
            style: const TextStyle(color: AppColors.error),
          ),
        ),
      ],
    );
  }
}
