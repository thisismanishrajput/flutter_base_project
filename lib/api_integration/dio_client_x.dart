import 'package:dio/dio.dart';
import 'package:flutter_base_project/api_integration/api_constants.dart';

import 'request_interceptor.dart';

class DioClientX {
  final Dio _dio = Dio();
  final String baseUrl = APIEndPoints.baseUrl;
  final RequestInterceptor requestInterceptor = RequestInterceptor();

  DioClientX();

  BaseOptions _dioOptions() {
    BaseOptions opts = BaseOptions();
    opts.baseUrl = baseUrl;
    opts.connectTimeout =
        const Duration(milliseconds: APIEndPoints.connectionTimeout);
    opts.receiveTimeout =
        const Duration(milliseconds: APIEndPoints.receiveTimeout);
    opts.sendTimeout = const Duration(milliseconds: APIEndPoints.sendTimeOut);
    return opts;
  }

  Dio provideDio() {
    _dio.options = _dioOptions();
    _dio.interceptors.add(requestInterceptor);
    return _dio;
  }
}
