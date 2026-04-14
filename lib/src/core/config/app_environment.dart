/// Supported application flavors.
enum Flavor { dev, prod }

/// Holds runtime environment values for the active flavor.
///
/// Initialize once at app startup using [init], then read anywhere via [instance].
class AppEnvironment {
  const AppEnvironment({
    required this.flavor,
    required this.appName,
    required this.baseUrl,
  });

  /// Active app flavor (for example: dev or prod).
  final Flavor flavor;

  /// App display title for the current flavor.
  final String appName;

  /// Base API URL used by networking layer.
  final String baseUrl;

  static late AppEnvironment _instance;

  /// Global singleton accessor after initialization.
  static AppEnvironment get instance => _instance;

  /// Initializes environment values during bootstrap.
  static void init({
    required Flavor flavor,
    required String appName,
    required String baseUrl,
  }) {
    _instance = AppEnvironment(
      flavor: flavor,
      appName: appName,
      baseUrl: baseUrl,
    );
  }
}
