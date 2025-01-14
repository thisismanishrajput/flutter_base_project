import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';

import '../services/session_manager/app_session_manager.dart';
import '../utility/constants/string_constants.dart';
import 'api_constants.dart';
import 'connectivity_service.dart';
import 'dio_exception.dart';
import 'request_interceptor.dart';

enum ContentType { urlEncoded, json, multipart }

class DioClient {
  final ConnectivityService connectivityService = ConnectivityService();

  DioClient() {
    _dio = Dio();
    _dio.options.sendTimeout =
        const Duration(milliseconds: APIEndPoints.sendTimeOut);
    _dio.options.connectTimeout =
        const Duration(milliseconds: APIEndPoints.connectionTimeout);
    _dio.options.receiveTimeout =
        const Duration(milliseconds: APIEndPoints.receiveTimeout);
    _dio.interceptors.add(RequestInterceptor());

    _baseUrl = APIEndPoints.baseUrl;
  }

  late Dio _dio;

  late String _baseUrl;

  Future<Either<String, Map<String, dynamic>>> patch(
    String path, {
    dynamic body,
    String? newBaseUrl,
    String? token,
    Map<String, String?>? query,
    ContentType contentType = ContentType.json,
  }) async {
    final hasConnection = await connectivityService.checkInternetConnection();
    if (!hasConnection) {
      return const Left(kNoInternetConnection);
    }
    String url;
    if (newBaseUrl != null) {
      url = newBaseUrl + path;
    } else {
      url = _baseUrl + path;
    }

    var content = 'application/x-www-form-urlencoded';

    if (contentType == ContentType.multipart) {
      content = 'multipart/form-data';
    } else if (contentType == ContentType.json) {
      content = 'application/json; charset=utf-8';
    }

    final headers = {
      'accept': '*/*',
      'Content-Type': content,
    };

    final appToken = AppSessionManager.instance.authToken;

    if (appToken?.isNotEmpty ?? false) {
      headers['AuthorizationToken'] = appToken!;
    }
    //Sometime for some specific endpoint it may require to use different Token
    if (token != null) {
      headers['AuthorizationToken'] = token;
    }

    try {
      final response = await _dio.patch(
        url,
        data: body ?? {},
        queryParameters: query,
        options: Options(headers: headers),
      );

      if (response.statusCode == null) {
        return const Left(kSomethingWentWrong);
      }

      if (response.statusCode! < 300) {
        return Right(response.data);
      } else {
        // Handle response error
        debugPrint('Error ${response.statusCode}: ${response.statusMessage}');
        return Left(handleError(response));
      }
    } on DioException catch (e) {
      if (e.error is SocketException) {
        return const Left(kNoInternetConnection);
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        return const Left(kRequestTimeout);
      } else {
        final errorMessage = DioExceptions.fromDioError(e).toString();
        return Left(errorMessage);
      }
    } catch (e, st) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: st);
      return Left(e.toString());
    }
  }

  Future<Either<String, Map<String, dynamic>>> post(
    String path, {
    dynamic body,
    String? newBaseUrl,
    String? token,
    Map<String, String?>? query,
    Map<String, String>? newHeaders,
    ContentType contentType = ContentType.json,
  }) async {
    final hasConnection = await connectivityService.checkInternetConnection();
    if (!hasConnection) {
      return const Left(kNoInternetConnection);
    }
    String url;
    if (newBaseUrl != null) {
      url = newBaseUrl + path;
    } else {
      url = _baseUrl + path;
    }

    var content = 'application/x-www-form-urlencoded';

    if (contentType == ContentType.multipart) {
      content = 'multipart/form-data';
    } else if (contentType == ContentType.json) {
      content = 'application/json; charset=utf-8';
    }

    final headers = {
      'accept': '*/*',
      'Content-Type': content,
    };

    if (newHeaders == null) {
      final appToken = AppSessionManager.instance.authToken;

      if (appToken?.isNotEmpty ?? false) {
        headers['AuthorizationToken'] = appToken!;
      }
      //Sometime for some specific endpoint it may require to use different Token
      if (token != null) {
        headers['AuthorizationToken'] = token;
      }
    }

    final appToken = AppSessionManager.instance.authToken;
    if (appToken?.isNotEmpty ?? false) {
      body =  {
        "api_token": appToken,
        "token":appToken
      };
    }

    try {
      final response = await _dio.post(
        url,
        data: body ?? {},
        queryParameters: query,
        options: Options(headers: newHeaders ?? headers),
      );

      if (response.statusCode == null) {
        return const Left(kSomethingWentWrong);
      }

      if (response.statusCode! < 300) {
        return Right(response.data);
      } else {
        // Handle response error
        debugPrint('Error ${response.statusCode}: ${response.statusMessage}');
        return Left(handleError(response));
      }
    } on DioException catch (e) {
      if (e.error is SocketException) {
        return const Left(kNoInternetConnection);
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        return const Left(kRequestTimeout);
      } else {
        final errorMessage = DioExceptions.fromDioError(e).toString();
        return Left(errorMessage);
      }
    } catch (e, st) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: st);
      return Left(e.toString());
    }
  }

  Future<Either<String, Map<String, dynamic>>> put(
    String path, {
    dynamic body,
    String? newBaseUrl,
    String? token,
    Map<String, String?>? query,
    ContentType contentType = ContentType.json,
  }) async {
    final hasConnection = await connectivityService.checkInternetConnection();
    if (!hasConnection) {
      return const Left(kNoInternetConnection);
    }
    String url;
    if (newBaseUrl != null) {
      url = newBaseUrl;
    } else {
      url = _baseUrl + path;
    }

    var content = 'application/x-www-form-urlencoded';

    if (contentType == ContentType.multipart) {
      content = 'multipart/form-data';
    } else if (contentType == ContentType.json) {
      content = 'application/json; charset=utf-8';
    }

    final headers = {
      'accept': '*/*',
      'Content-Type': content,
    };

    final appToken = AppSessionManager.instance.authToken;

    if (appToken?.isNotEmpty ?? false) {
      headers['AuthorizationToken'] = appToken!;
    }
    //Sometime for some specific endpoint it may require to use different Token
    if (token != null) {
      headers['AuthorizationToken'] = token;
    }

    try {
      final response = await _dio.put(
        url,
        data: body ?? {},
        queryParameters: query,
        options: Options(headers: headers),
      );

      if (response.statusCode == null) {
        return const Left(kSomethingWentWrong);
      }

      if (response.statusCode! < 300) {
        return Right(response.data);
      } else {
        // Handle response error
        debugPrint('Error ${response.statusCode}: ${response.statusMessage}');
        return Left(handleError(response));
      }
    } on DioException catch (e) {
      if (e.error is SocketException) {
        return const Left(kNoInternetConnection);
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        return const Left(kRequestTimeout);
      } else {
        final errorMessage = DioExceptions.fromDioError(e).toString();
        return Left(errorMessage);
      }
    } catch (e, st) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: st);
      return Left(e.toString());
    }
  }

  Future<Either<String, Map<String, dynamic>>> delete(
    String path, {
    dynamic body,
    String? newBaseUrl,
    String? token,
    Map<String, String?>? query,
    ContentType contentType = ContentType.json,
  }) async {
    final hasConnection = await connectivityService.checkInternetConnection();
    if (!hasConnection) {
      return const Left(kNoInternetConnection);
    }
    String url;
    if (newBaseUrl != null) {
      url = newBaseUrl + path;
    } else {
      url = _baseUrl + path;
    }

    var content = 'application/x-www-form-urlencoded';

    if (contentType == ContentType.multipart) {
      content = 'multipart/form-data';
    } else if (contentType == ContentType.json) {
      content = 'application/json; charset=utf-8';
    }

    final headers = {
      'accept': '*/*',
      'Content-Type': content,
    };

    final appToken = AppSessionManager.instance.authToken;

    if (appToken?.isNotEmpty ?? false) {
      headers['AuthorizationToken'] = appToken!;
    }
    //Sometime for some specific endpoint it may require to use different Token
    if (token != null) {
      headers['AuthorizationToken'] = token;
    }

    try {
      final response = await _dio.delete(
        url,
        data: body ?? {},
        queryParameters: query,
        options: Options(headers: headers),
      );

      if (response.statusCode == null) {
        return const Left(kSomethingWentWrong);
      }

      if (response.statusCode! < 300) {
        return Right(response.data);
      } else {
        // Handle response error
        debugPrint('Error ${response.statusCode}: ${response.statusMessage}');
        return Left(handleError(response));
      }
    } on DioException catch (e) {
      if (e.error is SocketException) {
        return const Left(kNoInternetConnection);
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        return const Left(kRequestTimeout);
      } else {
        final errorMessage = DioExceptions.fromDioError(e).toString();
        return Left(errorMessage);
      }
    } catch (e, st) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: st);
      return Left(e.toString());
    }
  }

  Future<Either<String, Map<String, dynamic>>> get(
    String path, {
    String? newBaseUrl,
    String? token,
    Map<String, dynamic>? query,
    Map<String, String>? newHeaders,
    MapEntry<String, String>? newHeader,
    ContentType contentType = ContentType.json,
  }) async {
    final hasConnection = await connectivityService.checkInternetConnection();
    if (!hasConnection) {
      return const Left(kNoInternetConnection);
    }
    String url;
    if (newBaseUrl != null) {
      url = newBaseUrl + path;
    } else {
      url = _baseUrl + path;
    }

    var content = 'application/x-www-form-urlencoded';

    if (contentType == ContentType.json) {
      content = 'application/json; charset=utf-8';
    }

    final headers = {
      'accept': '*/*',
      'Content-Type': content,
    };

    if (newHeaders == null) {
      final appToken = AppSessionManager.instance.authToken;

      if (appToken?.isNotEmpty ?? false) {
        headers['AuthorizationToken'] = appToken!;
      }
      //Sometime for some specific endpoint it may require to use different Token
      if (token != null) {
        headers['AuthorizationToken'] = token;
      }

      if (newHeader != null) {
        headers[newHeader.key] = newHeader.value;
      }
    }

    try {
      final response = await _dio.get(
        url,
        queryParameters: query,
        options: Options(headers: newHeaders ?? headers),
      );

      if (response.statusCode == null) {
        return const Left(kSomethingWentWrong);
      }

      if (response.statusCode! < 300) {
        return Right(response.data);
      } else {
        // Handle response error
        debugPrint('Error ${response.statusCode}: ${response.statusMessage}');
        return Left(handleError(response));
      }
    } on DioException catch (e) {
      if (e.error is SocketException) {
        return const Left(kNoInternetConnection);
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        return const Left(kRequestTimeout);
      } else {
        final errorMessage = DioExceptions.fromDioError(e).toString();
        return Left(errorMessage);
      }
    } catch (e, st) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: st);
      return Left(e.toString());
    }
  }
}
