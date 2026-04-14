import 'package:clean_arch_base/src/core/constants/app_strings.dart';
import 'package:equatable/equatable.dart';

/// Domain-safe failure base type returned via [Result].
sealed class Failure extends Equatable {
  const Failure(this.message);

  final String message;

  @override
  List<Object?> get props => <Object?>[message];
}

/// Failure representation for server/API issues.
class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

/// Failure representation for no network availability.
class NoInternetFailure extends Failure {
  const NoInternetFailure([super.message = AppStrings.noInternetAvailable]);
}

/// Failure representation for unexpected exceptions.
class UnknownFailure extends Failure {
  const UnknownFailure(super.message);
}
