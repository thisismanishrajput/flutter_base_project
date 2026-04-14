import 'package:clean_arch_base/src/core/constants/app_pref_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Shared preferences wrapper for auth/session related local persistence.
class SharedPrefService {
  const SharedPrefService({required SharedPreferences sharedPreferences})
    : _sharedPreferences = sharedPreferences;

  final SharedPreferences _sharedPreferences;

  /// Saves bearer access token.
  Future<bool> saveAccessToken(String token) {
    return _sharedPreferences.setString(AppPrefKeys.accessToken, token);
  }

  /// Alias for [saveAccessToken] to keep calling code concise.
  Future<bool> saveToken(String token) {
    return saveAccessToken(token);
  }

  /// Reads persisted access token.
  String? getAccessToken() {
    return _sharedPreferences.getString(AppPrefKeys.accessToken);
  }

  /// Alias for [getAccessToken].
  String? getToken() {
    return getAccessToken();
  }

  /// Saves refresh token.
  Future<bool> saveRefreshToken(String token) {
    return _sharedPreferences.setString(AppPrefKeys.refreshToken, token);
  }

  /// Reads persisted refresh token.
  String? getRefreshToken() {
    return _sharedPreferences.getString(AppPrefKeys.refreshToken);
  }

  /// Removes access token from local storage.
  Future<bool> clearAccessToken() {
    return _sharedPreferences.remove(AppPrefKeys.accessToken);
  }

  /// Alias for [clearAccessToken].
  Future<bool> clearToken() {
    return clearAccessToken();
  }

  /// Removes refresh token from local storage.
  Future<bool> clearRefreshToken() {
    return _sharedPreferences.remove(AppPrefKeys.refreshToken);
  }

  /// Clears both access and refresh tokens.
  Future<void> clearTokens() async {
    await clearAccessToken();
    await clearRefreshToken();
  }

  /// Logout helper that clears auth token data.
  Future<void> logout() async {
    await clearTokens();
  }

  /// Clears all persisted app preferences.
  Future<void> clearAll() async {
    await _sharedPreferences.clear();
  }

  /// Persists dark mode preference.
  Future<bool> saveIsDarkMode(bool isDarkMode) {
    return _sharedPreferences.setBool(AppPrefKeys.isDarkMode, isDarkMode);
  }

  /// Returns persisted dark mode preference if available.
  bool? getIsDarkMode() {
    return _sharedPreferences.getBool(AppPrefKeys.isDarkMode);
  }
}
