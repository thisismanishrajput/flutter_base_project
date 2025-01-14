import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_base_project/api_integration/dio_client.dart';
import 'package:flutter_base_project/api_integration/dio_client_x.dart';
import 'package:flutter_base_project/features/orders/data/repo_impl/orders_repo_impl.dart';
import 'package:flutter_base_project/features/orders/domain/repo/orders_repo.dart';


final serviceLocator = GetIt.instance;

Future<void> init() async {
  serviceLocator.registerLazySingleton<DioClient>(() => DioClient());
  serviceLocator.registerLazySingleton<Dio>(() => DioClientX().provideDio());
  serviceLocator.registerLazySingleton<OrdersRepo>(() => OrdersRepoImpl());
}
