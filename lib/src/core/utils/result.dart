import 'package:clean_arch_base/src/core/error/failures.dart';

/// Functional-style result wrapper for success/failure flows.
sealed class Result<T> {
  const Result();

  /// Pattern matching helper to process success and failure branches.
  R when<R>({
    required R Function(T data) success,
    required R Function(Failure failure) failure,
  });
}

/// Successful [Result] containing data payload.
class Success<T> extends Result<T> {
  const Success(this.data);

  final T data;

  @override
  R when<R>({
    required R Function(T data) success,
    required R Function(Failure failure) failure,
  }) {
    return success(data);
  }
}

/// Failed [Result] containing a typed [Failure].
class FailureResult<T> extends Result<T> {
  const FailureResult(this.error);

  final Failure error;

  @override
  R when<R>({
    required R Function(T data) success,
    required R Function(Failure failure) failure,
  }) {
    return failure(error);
  }
}
