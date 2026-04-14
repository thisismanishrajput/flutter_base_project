import 'package:clean_arch_base/src/core/constants/api_endpoints.dart';
import 'package:clean_arch_base/src/core/constants/app_strings.dart';
import 'package:clean_arch_base/src/core/error/error_handler.dart';
import 'package:clean_arch_base/src/core/error/exceptions.dart';
import 'package:dio/dio.dart';

/// Remote data source for auth API.
abstract class AuthRemoteDataSource {
  /// Logs in and returns access token.
  Future<String> login({required String username, required String password});
}

/// DummyJSON auth implementation.
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl({required Dio dio}) : _dio = dio;

  final Dio _dio;

  @override
  Future<String> login({
    required String username,
    required String password,
  }) async {
    try {
      final response = await _dio.post<dynamic>(
        ApiEndpoints.login,
        data: <String, dynamic>{'username': username, 'password': password},
      );

      final data = response.data;
      if (data is! Map<String, dynamic>) {
        throw const UnknownException(AppStrings.loginFailed);
      }

      final token = (data['accessToken'] ?? data['token'])?.toString() ?? '';
      if (token.isEmpty) {
        throw const UnknownException(AppStrings.loginFailed);
      }
      return token;
    } on DioException catch (error) {
      throw ErrorHandler.fromDioException(error);
    }
  }
}
