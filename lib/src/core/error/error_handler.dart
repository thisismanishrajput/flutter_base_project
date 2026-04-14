import 'package:clean_arch_base/src/core/constants/app_strings.dart';
import 'package:clean_arch_base/src/core/error/exceptions.dart';
import 'package:dio/dio.dart';

/// Converts low-level Dio errors into typed app exceptions.
class ErrorHandler {
  const ErrorHandler._();

  /// Maps [DioException] by error type/status code to user-friendly exceptions.
  static AppException fromDioException(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const ServerException(AppStrings.requestTimeout);
      case DioExceptionType.connectionError:
        return const NoInternetException(AppStrings.noInternet);
      case DioExceptionType.badResponse:
        return ServerException(
          _statusCodeMessage(exception.response?.statusCode),
        );
      case DioExceptionType.cancel:
        return const UnknownException(AppStrings.requestCancelled);
      case DioExceptionType.badCertificate:
      case DioExceptionType.unknown:
        return const UnknownException(AppStrings.somethingWentWrong);
    }
  }

  /// Maps HTTP status codes to readable messages.
  static String _statusCodeMessage(int? statusCode) {
    switch (statusCode) {
      case 400:
        return AppStrings.badRequest;
      case 401:
        return AppStrings.unauthorizedRequest;
      case 403:
        return AppStrings.accessDenied;
      case 404:
        return AppStrings.resourceNotFound;
      case 500:
        return AppStrings.serverError;
      case 502:
      case 503:
      case 504:
        return AppStrings.serverTemporarilyUnavailable;
      default:
        return AppStrings.unexpectedApiError;
    }
  }
}
