import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_project/utility/constants/string_constants.dart';

class DioExceptions implements Exception {
  late String message;

  DioExceptions.fromDioError(DioException dioError) {
    debugPrint('error type ${dioError.error}');
    switch (dioError.type) {
      case DioExceptionType.cancel:
        message = 'Request to API server was cancelled';
        break;
      case DioExceptionType.connectionTimeout:
        message = 'Connection timeout with API server';
        break;
      case DioExceptionType.receiveTimeout:
        message = 'Receive timeout in connection with API server';
        break;
      case DioExceptionType.badResponse:
        message = handleError(dioError.response, dioError.message);
        break;
      case DioExceptionType.sendTimeout:
        message = 'Send timeout in connection with API server';
        break;
      case DioExceptionType.unknown:
        if (dioError.message?.contains('SocketException') ?? false) {
          message = kNoInternetConnection;
          break;
        } else if (dioError.response?.statusCode == 403) {
          message = 'Server Error';
          break;
        }
        message = 'Unexpected error occurred';
        break;
      default:
        message = 'Something went wrong';
        break;
    }
  }

  @override
  String toString() => message;
}

String handleError(Response? response, [String? dioErrorMessage]) {
  if (response?.statusCode != null) {
    if (response!.statusCode! < 500) {
      if (response.data is Map) {
        return response.data?['message'] ?? response.statusMessage;
      } else {
        return response.statusMessage ?? dioErrorMessage ?? kSomethingWentWrong;
      }
    } else {
      return response.statusMessage ?? dioErrorMessage ?? kSomethingWentWrong;
    }
  } else {
    return dioErrorMessage ?? kSomethingWentWrong;
  }
}
