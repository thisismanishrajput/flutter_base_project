import 'package:clean_arch_base/src/core/utils/result.dart';

/// Domain contract for auth operations.
abstract class AuthRepository {
  /// Authenticates user and persists access token on success.
  Future<Result<void>> login({
    required String username,
    required String password,
  });

  /// Clears auth session.
  Future<void> logout();

  /// Returns true when access token is available.
  bool isLoggedIn();
}
