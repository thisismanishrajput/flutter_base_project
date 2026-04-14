import 'package:clean_arch_base/src/core/constants/api_endpoints.dart';
import 'package:clean_arch_base/src/core/constants/network_headers.dart';
import 'package:clean_arch_base/src/core/network/dio_logging_interceptor.dart';
import 'package:clean_arch_base/src/core/storage/shared_pref_service.dart';
import 'package:dio/dio.dart';

/// Factory for creating configured Dio client instances.
class DioClient {
  DioClient._();

  /// Builds a Dio instance with common options, token injection, and logging.
  static Dio create({required SharedPrefService sharedPrefService}) {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
        sendTimeout: const Duration(seconds: 20),
        headers: <String, String>{
          NetworkHeaders.contentType: 'application/json',
          NetworkHeaders.accept: 'application/json',
        },
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
          // Always read token at request time so the latest login/logout state
          // is reflected without recreating Dio.
          final token = sharedPrefService.getAccessToken();
          if (token != null && token.isNotEmpty) {
            options.headers[NetworkHeaders.authorization] =
                '${NetworkHeaders.bearerPrefix} $token';
          } else {
            options.headers.remove(NetworkHeaders.authorization);
          }
          handler.next(options);
        },
      ),
    );

    // Add verbose network request/response/error logs.
    dio.interceptors.add(DioLoggingInterceptor());

    return dio;
  }
}
