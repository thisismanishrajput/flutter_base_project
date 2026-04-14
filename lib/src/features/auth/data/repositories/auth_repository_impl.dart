import 'package:clean_arch_base/src/core/constants/app_strings.dart';
import 'package:clean_arch_base/src/core/error/exceptions.dart';
import 'package:clean_arch_base/src/core/error/failures.dart';
import 'package:clean_arch_base/src/core/network/auth_session_manager.dart';
import 'package:clean_arch_base/src/core/utils/result.dart';
import 'package:clean_arch_base/src/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:clean_arch_base/src/features/auth/domain/repositories/auth_repository.dart';

/// Auth repository implementation.
class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({
    required AuthRemoteDataSource remoteDataSource,
    required AuthSessionManager authSessionManager,
  }) : _remoteDataSource = remoteDataSource,
       _authSessionManager = authSessionManager;

  final AuthRemoteDataSource _remoteDataSource;
  final AuthSessionManager _authSessionManager;

  @override
  Future<Result<void>> login({
    required String username,
    required String password,
  }) async {
    try {
      final token = await _remoteDataSource.login(
        username: username,
        password: password,
      );
      await _authSessionManager.setAccessToken(token);
      return const Success<void>(null);
    } on ServerException catch (error) {
      return FailureResult<void>(ServerFailure(error.message));
    } on AppException catch (error) {
      return FailureResult<void>(UnknownFailure(error.message));
    } catch (_) {
      return const FailureResult<void>(UnknownFailure(AppStrings.loginFailed));
    }
  }

  @override
  Future<void> logout() {
    return _authSessionManager.logout();
  }

  @override
  bool isLoggedIn() {
    final token = _authSessionManager.getAccessToken();
    return token != null && token.isNotEmpty;
  }
}
