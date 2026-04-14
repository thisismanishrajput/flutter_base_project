import 'package:clean_arch_base/src/core/config/app_environment.dart';

/// Centralized API endpoints.
class ApiEndpoints {
  const ApiEndpoints._();

  /// Base URL resolved from the active runtime environment.
  static String get baseUrl => AppEnvironment.instance.baseUrl;

  /// Products listing endpoint.
  static const String products = '/products';

  /// DummyJSON login endpoint.
  static const String login = '/auth/login';
}
