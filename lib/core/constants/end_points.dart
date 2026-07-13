abstract class EndPoints {
  static const String baseUrl = 'https://pharmacy-api.bya3online.com/api/v1';
  static const String mediaBaseUrl = 'https://pharmacy-api.bya3online.com';

  // Categories
  static const String categories = '/categories';

  // Combo Offers
  static const String activeComboOffers = '/combo-offers/active';

  // Authentication
  static const String login = '/auth/login';
  static const String customerRegister = '/auth/customer/register';
  static const String me = '/auth/me';
  static const String updateMe = '/auth/me';
  static const String changePassword = '/auth/me/password';
  static const String register = '/auth/register';
  static const String refresh = '/auth/refresh';
  static const String logout = '/auth/logout';

  static String customerSocialLogin(String provider) =>
      '/auth/customer/login/$provider';

  static String customerSocialLoginCallback(String provider) =>
      '/auth/customer/login/$provider/callback';
}
