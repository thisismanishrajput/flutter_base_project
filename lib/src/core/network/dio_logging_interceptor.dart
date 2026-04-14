import 'package:clean_arch_base/src/core/constants/network_headers.dart';
import 'package:clean_arch_base/src/core/logger/app_logger.dart';
import 'package:dio/dio.dart';

/// Verbose network logger interceptor for request/response/error visibility.
class DioLoggingInterceptor extends Interceptor {
  DioLoggingInterceptor({this.maxBodyChars = 3000});

  final int maxBodyChars;
  static const String _tag = 'NETWORK';
  static const String _startTimeKey = 'request_start_time_ms';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.extra[_startTimeKey] = DateTime.now().millisecondsSinceEpoch;

    AppLogger.info(
      _tag,
      '${options.method} ${options.uri}',
      data: <String, dynamic>{
        'method': options.method,
        'url': options.uri.toString(),
        'headers': _maskHeaders(options.headers),
        'query': options.queryParameters,
        'body': _truncate(options.data),
      },
    );
    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    final durationMs = _duration(response.requestOptions);
    AppLogger.debug(
      _tag,
      '${response.requestOptions.method} ${response.requestOptions.uri} (${response.statusCode})',
      data: <String, dynamic>{
        'statusCode': response.statusCode,
        'durationMs': durationMs,
        'response': _truncate(response.data),
      },
    );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final durationMs = _duration(err.requestOptions);
    AppLogger.error(
      _tag,
      '${err.requestOptions.method} ${err.requestOptions.uri} failed',
      error: err,
      stackTrace: err.stackTrace,
      data: <String, dynamic>{
        'statusCode': err.response?.statusCode,
        'durationMs': durationMs,
        'message': err.message,
        'requestHeaders': _maskHeaders(err.requestOptions.headers),
        'requestQuery': err.requestOptions.queryParameters,
        'requestBody': _truncate(err.requestOptions.data),
        'responseBody': _truncate(err.response?.data),
      },
    );
    handler.next(err);
  }

  Map<String, dynamic> _maskHeaders(Map<String, dynamic> headers) {
    final masked = Map<String, dynamic>.from(headers);
    if (masked.containsKey(NetworkHeaders.authorization)) {
      masked[NetworkHeaders.authorization] = '***masked***';
    }
    return masked;
  }

  int? _duration(RequestOptions options) {
    final start = options.extra[_startTimeKey];
    if (start is! int) return null;
    return DateTime.now().millisecondsSinceEpoch - start;
  }

  Object? _truncate(Object? value) {
    if (value == null) return null;
    final text = value.toString();
    if (text.length <= maxBodyChars) return value;
    return '${text.substring(0, maxBodyChars)}...<truncated>';
  }
}
