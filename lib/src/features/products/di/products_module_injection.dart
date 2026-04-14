import 'package:clean_arch_base/src/features/products/data/datasources/product_remote_datasource.dart';
import 'package:clean_arch_base/src/features/products/data/repositories/product_repository_impl.dart';
import 'package:clean_arch_base/src/features/products/domain/repositories/product_repository.dart';
import 'package:clean_arch_base/src/features/products/domain/usecases/get_products_usecase.dart';
import 'package:clean_arch_base/src/features/products/presentation/bloc/product_bloc.dart';
import 'package:get_it/get_it.dart';

/// Registers products feature dependencies.
void initProductsModule(GetIt sl) {
  sl.registerFactory<ProductBloc>(() => ProductBloc(getProductsUsecase: sl()));

  sl.registerLazySingleton<GetProductsUsecase>(
    () => GetProductsUsecase(repository: sl()),
  );

  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );

  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(dio: sl()),
  );
}
