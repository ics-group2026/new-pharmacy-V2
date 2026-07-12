abstract class EndPoints {
  static const String baseUrl = 'https://pharmacy-api.bya3online.com/api/v1';

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
