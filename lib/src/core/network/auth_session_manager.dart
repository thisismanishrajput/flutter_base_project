import 'package:clean_arch_base/src/core/constants/network_headers.dart';
import 'package:clean_arch_base/src/core/storage/shared_pref_service.dart';
import 'package:dio/dio.dart';

/// Coordinates auth token persistence and network header synchronization.
class AuthSessionManager {
  const AuthSessionManager({
    required SharedPrefService sharedPrefService,
    required Dio dio,
  }) : _sharedPrefService = sharedPrefService,
       _dio = dio;

  final SharedPrefService _sharedPrefService;
  final Dio _dio;

  /// Persists access token and applies it to Dio authorization header.
  Future<void> setAccessToken(String token) async {
    await _sharedPrefService.saveAccessToken(token);
    _setAuthHeader(token);
  }

  /// Returns the persisted access token, if available.
  String? getAccessToken() {
    return _sharedPrefService.getAccessToken();
  }

  /// Clears only access token and removes auth header from Dio.
  Future<void> clearAccessToken() async {
    await _sharedPrefService.clearAccessToken();
    _removeAuthHeader();
  }

  /// Clears token data for sign-out flow and resets auth header.
  Future<void> logout() async {
    await _sharedPrefService.logout();
    _removeAuthHeader();
  }

  /// Clears all persisted data and resets auth header.
  Future<void> clearAll() async {
    await _sharedPrefService.clearAll();
    _removeAuthHeader();
  }

  /// Restores persisted token into Dio headers at app startup.
  void hydrateAccessTokenToHeader() {
    final token = _sharedPrefService.getAccessToken();
    if (token != null && token.isNotEmpty) {
      _setAuthHeader(token);
    } else {
      _removeAuthHeader();
    }
  }

  /// Sets the default authorization header for all outgoing requests.
  void _setAuthHeader(String token) {
    _dio.options.headers[NetworkHeaders.authorization] =
        '${NetworkHeaders.bearerPrefix} $token';
  }

  /// Removes authorization header when user is unauthenticated.
  void _removeAuthHeader() {
    _dio.options.headers.remove(NetworkHeaders.authorization);
  }
}
