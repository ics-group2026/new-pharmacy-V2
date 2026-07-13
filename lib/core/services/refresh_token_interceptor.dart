import 'package:dio/dio.dart';

import '../constants/constants.dart';
import '../constants/end_points.dart';
import 'prefs.dart';

class RefreshTokenInterceptor extends QueuedInterceptorsWrapper {
  final Dio dio;

  RefreshTokenInterceptor({required this.dio});

  // ── Inject the stored Bearer token into every outgoing request ──────────
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final String? token = Prefs.getString(kToken);
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  // ── On 401: attempt a token refresh then retry original request ──────────
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final String? refreshToken = Prefs.getString(kRefreshToken);

      // Guard: nothing to refresh with
      if (refreshToken == null || refreshToken.isEmpty) {
        handler.next(err);
        return;
      }

      try {
        // Use a fresh Dio to avoid an interceptor loop
        final freshDio = Dio(BaseOptions(baseUrl: EndPoints.baseUrl));
        final response = await freshDio.post(
          EndPoints.refresh,
          data: {'refreshToken': refreshToken},
        );

        final data = (response.data as Map<String, dynamic>)['data'] as Map<String, dynamic>;
        final String newToken = data['accessToken'] as String;
        final String newRefreshToken = data['refreshToken'] as String;

        // Persist new credentials
        await Prefs.setString(kToken, newToken);
        await Prefs.setString(kRefreshToken, newRefreshToken);

        // Retry the original request with the new token
        final retryOptions = err.requestOptions;
        retryOptions.headers['Authorization'] = 'Bearer $newToken';

        final retryResponse = await dio.fetch(retryOptions);
        handler.resolve(retryResponse);
      } on DioException catch (_) {
        handler.next(err);
      }
    } else {
      handler.next(err);
    }
  }
}
