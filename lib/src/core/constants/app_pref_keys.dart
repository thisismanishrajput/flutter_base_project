/// Keys used for local persistence in shared preferences.
class AppPrefKeys {
  const AppPrefKeys._();

  /// Persisted bearer access token key.
  static const String accessToken = 'access_token';

  /// Persisted refresh token key.
  static const String refreshToken = 'refresh_token';

  /// Persisted theme mode key (true = dark, false = light).
  static const String isDarkMode = 'is_dark_mode';
}
