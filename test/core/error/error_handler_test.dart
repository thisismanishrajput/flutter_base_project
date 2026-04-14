import 'package:clean_arch_base/src/core/constants/app_strings.dart';
import 'package:clean_arch_base/src/core/error/error_handler.dart';
import 'package:clean_arch_base/src/core/error/exceptions.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ErrorHandler.fromDioException', () {
    test('maps connection errors to NoInternetException', () {
      final exception = DioException(
        requestOptions: RequestOptions(path: '/products'),
        type: DioExceptionType.connectionError,
      );

      final result = ErrorHandler.fromDioException(exception);

      expect(result, isA<NoInternetException>());
      expect(result.message, AppStrings.noInternet);
    });

    test('maps 401 responses to unauthorized message', () {
      final exception = DioException(
        requestOptions: RequestOptions(path: '/auth/login'),
        response: Response<dynamic>(
          requestOptions: RequestOptions(path: '/auth/login'),
          statusCode: 401,
        ),
        type: DioExceptionType.badResponse,
      );

      final result = ErrorHandler.fromDioException(exception);

      expect(result, isA<ServerException>());
      expect(result.message, AppStrings.unauthorizedRequest);
    });
  });
}
