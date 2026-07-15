abstract class EndPoints {
  static const String baseUrl = 'https://pharmacy-api.bya3online.com/api/v1';
  static const String mediaBaseUrl = 'https://pharmacy-api.bya3online.com';

  // Categories
  static const String categories = '/categories';

  // Products
  static const String products = '/products';

  // Combo Offers
  static const String activeComboOffers = '/combo-offers/active';

  // Deals (flash deals are deals with type == 'FLASH')
  static const String activeDeals = '/deals/active';

  // Bundles
  static const String activeBundles = '/bundles/active';

  static String activeBundleById(String id) => '/bundles/active/$id';

  // Marketing / Banners
  static const String storefrontBanners = '/marketing/banners/storefront';

  // Notifications
  static const String notificationsInbox = '/notifications/inbox/me';
  static const String notificationsUnreadCount =
      '/notifications/inbox/me/unread-count';

  static String notificationMarkAsRead(String id) => '/notifications/inbox/$id/read';

  static const String notificationsMarkAllAsRead = '/notifications/inbox/read-all';

  // Authentication
  static const String login = '/auth/login';
  static const String customerRegister = '/auth/customer/register';
  static const String me = '/auth/me';
  static const String updateMe = '/auth/me';
  static const String deleteMe = '/auth/me';
  static const String changePassword = '/auth/me/password';
  static const String register = '/auth/register';
  static const String refresh = '/auth/refresh';
  static const String logout = '/auth/logout';

  static String customerSocialLogin(String provider) =>
      '/auth/customer/login/$provider';

  static String customerSocialLoginCallback(String provider) =>
      '/auth/customer/login/$provider/callback';
}
