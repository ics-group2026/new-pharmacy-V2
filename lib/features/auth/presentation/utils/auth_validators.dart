import '../../../../core/utils/app_regx.dart';
import '../../../../core/utils/app_translations.dart';

abstract class AuthValidators {
  static String? validateFullName(String? value) {
    final name = value?.trim() ?? '';
    if (name.isEmpty) {
      return AppTranslations.t('auth.validation.name_required');
    }
    if (!name.contains(' ')) {
      return AppTranslations.t('auth.validation.name_full');
    }
    return null;
  }

  static String? validateEmail(String? value) {
    final email = value?.trim() ?? '';
    if (email.isEmpty) {
      return AppTranslations.t('auth.validation.email_required');
    }
    if (!AppRegex.isEmailValid(email)) {
      return AppTranslations.t('auth.validation.email_invalid');
    }
    return null;
  }

  static String? validatePassword(String? value) {
    final password = value ?? '';
    if (password.isEmpty) {
      return AppTranslations.t('auth.validation.password_required');
    }
    if (!AppRegex.hasMinLength(password)) {
      return AppTranslations.t('auth.validation.password_min_length');
    }
    if (!AppRegex.hasNumber(password)) {
      return AppTranslations.t('auth.validation.password_number');
    }
    if (!AppRegex.hasSpecialCharacter(password)) {
      return AppTranslations.t('auth.validation.password_special');
    }
    return null;
  }

  static String? validateConfirmPassword(String? value, String password) {
    final confirm = value ?? '';
    if (confirm.isEmpty) {
      return AppTranslations.t('auth.validation.confirm_password_required');
    }
    if (confirm != password) {
      return AppTranslations.t('auth.validation.confirm_password_mismatch');
    }
    return null;
  }
}
