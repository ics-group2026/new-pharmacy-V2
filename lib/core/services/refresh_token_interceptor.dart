// ignore_for_file: unused_import

import 'package:dio/dio.dart';

import '../constants/constants.dart';
import '../constants/end_points.dart';
import '../errors/failure.dart';
import 'prefs.dart';

class RefreshTokenInterceptor extends QueuedInterceptorsWrapper {
  final Dio dio;

  RefreshTokenInterceptor({required this.dio});

  // ── Inject the stored Bearer token into every outgoing request ──────────
  // @override
  // void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
  //   final String? token = Prefs.getString(kToken);
  //   if (token != null && token.isNotEmpty) {
  //     options.headers['Authorization'] = 'Bearer $token';
  //   }
  //   handler.next(options);
  // }

  // ── On 401: attempt a token refresh then retry original request ──────────
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final String? token = Prefs.getString(kToken);
      final String? refreshToken = Prefs.getString(kRefreshToken);

      // Guard: nothing to refresh with
      if (token == null || refreshToken == null) {
        handler.next(err);
        return;
      }

      try {
        // Use a fresh Dio to avoid an interceptor loop
        final freshDio = Dio(BaseOptions(baseUrl: ""));
        final response = await freshDio.post(
          "",
          data: {'token': token, 'refreshToken': refreshToken},
        );

        final Map<String, dynamic> result = response.data as Map<String, dynamic>;

        // Persist new credentials
        final String newToken = result['token'];
        // saveUserData(result);

        // Retry the original request with the new token
        final retryOptions = err.requestOptions;
        retryOptions.headers['Authorization'] = 'Bearer $newToken';

        final retryResponse = await dio.fetch(retryOptions);
        handler.resolve(retryResponse);
      } on DioException catch (_) {
        // ServerFailure.fromDioExcepiton(e);
        handler.next(err);
      }
    } else {
      handler.next(err);
    }
  }
}
