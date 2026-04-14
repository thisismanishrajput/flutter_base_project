import 'package:clean_arch_base/src/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:clean_arch_base/src/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:clean_arch_base/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:clean_arch_base/src/features/auth/domain/usecases/login_usecase.dart';
import 'package:clean_arch_base/src/features/auth/domain/usecases/logout_usecase.dart';
import 'package:clean_arch_base/src/features/auth/presentation/bloc/login_bloc.dart';
import 'package:get_it/get_it.dart';

/// Registers auth feature dependencies.
void initAuthModule(GetIt sl) {
  sl.registerFactory<LoginBloc>(() => LoginBloc(loginUsecase: sl()));

  sl.registerLazySingleton<LoginUsecase>(() => LoginUsecase(repository: sl()));
  sl.registerLazySingleton<LogoutUsecase>(
    () => LogoutUsecase(repository: sl()),
  );

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl(), authSessionManager: sl()),
  );

  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(dio: sl()),
  );
}
