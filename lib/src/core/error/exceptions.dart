/// Base app exception for data-source/network thrown errors.
class AppException implements Exception {
  const AppException(this.message);

  final String message;
}

/// Represents server-side/API failures.
class ServerException extends AppException {
  const ServerException(super.message);
}

/// Represents internet connectivity failures.
class NoInternetException extends AppException {
  const NoInternetException(super.message);
}

/// Represents unknown/unclassified runtime failures.
class UnknownException extends AppException {
  const UnknownException(super.message);
}
