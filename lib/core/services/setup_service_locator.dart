import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../../features/auth/data/repos/auth_repo.dart';
import '../../features/auth/data/repos/auth_repo_impl.dart';
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

  /// Cubits
  // Shared so the account header and the edit-profile screen stay in sync.
  getIt.registerLazySingleton<ProfileCubit>(
    () => ProfileCubit(getIt<ProfileRepo>()),
  );
}
