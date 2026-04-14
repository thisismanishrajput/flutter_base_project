import 'package:clean_arch_base/src/features/auth/domain/repositories/auth_repository.dart';

/// Use case to clear current auth session.
class LogoutUsecase {
  const LogoutUsecase({required AuthRepository repository})
    : _repository = repository;

  final AuthRepository _repository;

  Future<void> call() {
    return _repository.logout();
  }
}
