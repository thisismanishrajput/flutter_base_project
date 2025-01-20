import 'package:fpdart/fpdart.dart';

typedef VoidToVoidFunc = void Function();
typedef VoidToIntFunc = void Function(int);
typedef StringToVoidFunc = void Function(String);
typedef IntStringToVoidFunc = void Function(int, String);
typedef StringBoolToVoidFunc = void Function(bool, String);
typedef FutureEither<T> = Future<Either<String, T>>;
typedef EitherError<T> = Either<String, T>;
typedef VideoRecord = (String filePath, String? thumbnailPath);
