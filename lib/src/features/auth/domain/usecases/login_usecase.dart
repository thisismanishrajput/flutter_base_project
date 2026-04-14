import 'package:clean_arch_base/src/core/utils/result.dart';
import 'package:clean_arch_base/src/features/auth/domain/repositories/auth_repository.dart';

/// Use case to perform login.
class LoginUsecase {
  const LoginUsecase({required AuthRepository repository})
    : _repository = repository;

  final AuthRepository _repository;

  Future<Result<void>> call({
    required String username,
    required String password,
  }) {
    return _repository.login(username: username, password: password);
  }
}
