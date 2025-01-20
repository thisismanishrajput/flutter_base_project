import 'package:dio/dio.dart';
import 'package:flutter_base_project/features/orders/domain/local/app_local_db.dart';
import 'package:flutter_base_project/services/object_box_service.dart';
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
Future<void> initDB() async {
  try {
    await closeDB();
  } catch (_) {}


  /// init Local DBs.
   OrderDB snippetDb = OrderDB();
  snippetDb.init();
  serviceLocator.registerSingleton<OrderDB>(OrderDB());
}



Future<void> closeDB() async {
   await serviceLocator.unregister<OrderDB>();
}

