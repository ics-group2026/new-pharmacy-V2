import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../../features/auth/data/repos/auth_repo.dart';
import '../../features/auth/data/repos/auth_repo_impl.dart';
import '../../features/banners/data/repos/banners_repo.dart';
import '../../features/banners/data/repos/banners_repo_impl.dart';
import '../../features/bundles/data/repos/bundles_repo.dart';
import '../../features/bundles/data/repos/bundles_repo_impl.dart';
import '../../features/categories/data/repos/categories_repo.dart';
import '../../features/categories/data/repos/categories_repo_impl.dart';
import '../../features/combo_offers/data/repos/combo_offers_repo.dart';
import '../../features/combo_offers/data/repos/combo_offers_repo_impl.dart';
import '../../features/flash_deals/data/repos/flash_deals_repo.dart';
import '../../features/flash_deals/data/repos/flash_deals_repo_impl.dart';
import '../../features/notifications/data/repos/notifications_repo.dart';
import '../../features/notifications/data/repos/notifications_repo_impl.dart';
import '../../features/notifications/presentation/cubits/unread_notifications_cubit.dart';
import '../../features/products/data/repos/products_repo.dart';
import '../../features/products/data/repos/products_repo_impl.dart';
import '../../features/profile/data/repos/profile_repo.dart';
import '../../features/profile/data/repos/profile_repo_impl.dart';
import '../../features/profile/presentation/cubits/profile_cubit.dart';
import 'api_service.dart';
import 'dio_consumer.dart';

final getIt = GetIt.instance;
void setupServiceLocator() {
  getIt.registerSingleton<Dio>(Dio());
  getIt.registerSingleton<ApiService>(DioConsumer(dio: getIt<Dio>()));

  /// Repositories
  getIt.registerSingleton<AuthRepo>(AuthRepoImpl(apiService: getIt<ApiService>()));
  getIt.registerSingleton<ProfileRepo>(
    ProfileRepoImpl(apiService: getIt<ApiService>()),
  );
  getIt.registerSingleton<CategoriesRepo>(
    CategoriesRepoImpl(apiService: getIt<ApiService>()),
  );
  getIt.registerSingleton<ComboOffersRepo>(
    ComboOffersRepoImpl(apiService: getIt<ApiService>()),
  );
  getIt.registerSingleton<FlashDealsRepo>(
    FlashDealsRepoImpl(apiService: getIt<ApiService>()),
  );
  getIt.registerSingleton<BannersRepo>(
    BannersRepoImpl(apiService: getIt<ApiService>()),
  );
  getIt.registerSingleton<BundlesRepo>(
    BundlesRepoImpl(apiService: getIt<ApiService>()),
  );
  getIt.registerSingleton<NotificationsRepo>(
    NotificationsRepoImpl(apiService: getIt<ApiService>()),
  );
  getIt.registerSingleton<ProductsRepo>(
    ProductsRepoImpl(apiService: getIt<ApiService>()),
  );

  /// Cubits
  // Shared so the account header and the edit-profile screen stay in sync.
  getIt.registerLazySingleton<ProfileCubit>(
    () => ProfileCubit(getIt<ProfileRepo>()),
  );
  // Shared so the home app bar badge reflects the count across navigation.
  getIt.registerLazySingleton<UnreadNotificationsCubit>(
    () => UnreadNotificationsCubit(getIt<NotificationsRepo>()),
  );
}
