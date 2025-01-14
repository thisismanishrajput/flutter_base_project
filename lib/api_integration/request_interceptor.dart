import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_base_project/features/user-onboard/presentation/view/login_screen.dart';

import '../core/router/router.dart';
import '../services/session_manager/app_session_manager.dart';

class RequestInterceptor extends Interceptor {
  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    if (kDebugMode) {
      log("=== Dio Error !!!! ====>>>> ${err.toString()}");
      if (err.response != null) {
        log("=== Error Response ====>>>> ${err.response.toString()}");
      }
    }
    await _handleErrors(err, handler);
    return super.onError(err, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      // log("=== Dio BaseUrl ====>>>> ${options.baseUrl}");
      // log("=== Dio Headers ====>>>> ${options.headers}");
      log("=== Dio Request ====>>>> ${options.method} => ${options.path} => ${options.contentType}");
      log("=== Dio Request parameters ====>>>> query: ${json.encode(options.queryParameters)}  data: ${options.data is String ? options.data : json.encode(options.data)}");
    }
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      log("=== Dio Response ====>>>> ${response.data is String ? response.data : json.encode(response.data)}");
    }
    if (response.data['statusCode'] == 106) {
      return handler.reject(
          DioException(
            requestOptions: response.requestOptions,
            error: 'UnAuthorised User',
            type: DioExceptionType.badResponse,
            response: Response(
              statusCode: 401,
              statusMessage: 'UnAuthorised User',
              requestOptions: response.requestOptions,
            ),
          ),
          true);
    } else if (response.data['statusCode'] == 431) {
      return handler.reject(
          DioException(
            requestOptions: response.requestOptions,
            error: 'Upgrade Required',
            type: DioExceptionType.badResponse,
            response: Response(
              statusCode: 426,
              statusMessage: 'Upgrade Required',
              requestOptions: response.requestOptions,
            ),
          ),
          true);
    }
    return super.onResponse(response, handler);
  }

  Future<void> _handleErrors(
      DioException error, ErrorInterceptorHandler handler) async {
    if (error.response?.statusCode != null) {

      switch (error.response?.statusCode) {
        case 401:
          // Handle 401 (refresh access token)
          String? newAccessToken = await _refreshToken();
          if (newAccessToken != null) {
            error.requestOptions.headers['AuthorizationToken'] = newAccessToken;
            return handler.resolve(await Dio().fetch(error.requestOptions));
          } else {
            await AppSessionManager.instance.clearPref();
            navigatorKey.currentContext!.goNamed(LoginScreen.routeName);
          }
        case 403:
        // Handle 403 and 500 (reject error)
        case 500:
        // Handle 403 and 500 (reject error)
        default:
        // Handle other cases (optional)
      }
    }
  }

  Future<String?> _refreshToken() async {
    return null;

    // final refreshToken = AppSessionManager.instance.refreshToken;
    // final headers = {
    //   'accept': '*/*',
    //   'Content-Type': 'application/json; charset=utf-8',
    //   'AuthorizationToken': refreshToken,
    // };
    // final result = await Dio().get(
    //     APIEndPoints.baseUrl + APIEndPoints.generateNewAccessToken,
    //     options: Options(headers: headers),
    //     queryParameters: {'login_platform': 'MOBILE'});
    // if (result.data['statusCode'] == 107) {
    //   final NewAccessTokenModel newAccessTokenModel =
    //       NewAccessTokenModel.fromMap(result.data);
    //   AppSessionManager.instance.saveAuthToken(
    //       authToken: newAccessTokenModel.data?.accessToken ?? '');
    //   AppSessionManager.instance.saveRefreshToken(
    //       refreshToken: newAccessTokenModel.data?.refreshToken ?? '');
    //   AppSessionManager.instance
    //       .saveAccessTokenGeneratedTime(DateTime.now().millisecondsSinceEpoch);
    //   return newAccessTokenModel.data?.accessToken ?? '';
    // } else {
    //   return null;
    // }
  }
}
