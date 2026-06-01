abstract class AppRegex {
  static bool isEmailValid(String email) {
    return RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$').hasMatch(email);
  }

  static bool hasMinLength(String password) {
    return password.length >= 8;
  }

  static bool hasNumber(String password) {
    return RegExp(r'\d').hasMatch(password);
  }

  static bool hasSpecialCharacter(String password) {
    return RegExp(r'[@$!%*#?&]').hasMatch(password);
  }

  static bool isPhoneNumberValid(String phoneNumber) {
    return RegExp(r'^(010|011|012|015)[0-9]{8}$').hasMatch(phoneNumber);
  }
}
