import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'api_service.dart';
import 'dio_consumer.dart';

final getIt = GetIt.instance;
void setupServiceLocator() {
  getIt.registerSingleton<Dio>(Dio());
  getIt.registerSingleton<ApiService>(DioConsumer(dio: getIt<Dio>()));

  /// Repositories
  

  /// Cubits
}
