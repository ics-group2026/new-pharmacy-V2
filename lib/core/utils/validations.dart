import 'package:easy_localization/easy_localization.dart';

import 'app_regx.dart';

abstract class Validations {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required'.tr();
    }
    if (!AppRegex.isEmailValid(value)) {
      return 'Enter a valid email address'.tr();
    }
    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required'.tr();
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required'.tr();
    }
    if (!AppRegex.hasMinLength(value)) {
      return 'Password must be at least 8 characters'.tr();
    }
    if (!AppRegex.hasNumber(value)) {
      return 'Password must contain at least one number'.tr();
    }
    if (!AppRegex.hasSpecialCharacter(value)) {
      return 'Password must contain at least one special character (@\$!%*#?&)'.tr();
    }
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required'.tr();
    }
    if (!AppRegex.isPhoneNumberValid(value)) {
      return 'Enter a valid Egyptian phone number'.tr();
    }
    return null;
  }

  static String? required(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required'.tr();
    }
    return null;
  }

  static String? confirmPassword(String? value, String originalPassword) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password'.tr();
    }
    if (value != originalPassword) {
      return 'Passwords do not match'.tr();
    }
    return null;
  }

  static String? validateMessage(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Message is required'.tr();
  }
  if (value.trim().length < 10) {
    return 'Message must be at least 10 characters'.tr();
  }
  return null;
}
}
