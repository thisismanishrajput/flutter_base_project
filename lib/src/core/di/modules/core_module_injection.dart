import 'package:clean_arch_base/src/core/network/auth_session_manager.dart';
import 'package:clean_arch_base/src/core/network/dio_client.dart';
import 'package:clean_arch_base/src/core/network/network_info.dart';
import 'package:clean_arch_base/src/core/storage/shared_pref_service.dart';
import 'package:clean_arch_base/src/core/theme/theme_cubit.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Registers shared core dependencies used by all features.
Future<void> initCoreModule(GetIt sl) async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPrefService>(
    () => SharedPrefService(sharedPreferences: sharedPreferences),
  );

  sl.registerLazySingleton<Dio>(
    () => DioClient.create(sharedPrefService: sl()),
  );

  sl.registerLazySingleton<AuthSessionManager>(
    () => AuthSessionManager(sharedPrefService: sl(), dio: sl()),
  );
  sl.registerLazySingleton<ThemeCubit>(
    () => ThemeCubit(sharedPrefService: sl()),
  );

  sl.registerLazySingleton<Connectivity>(Connectivity.new);
  sl.registerLazySingleton<InternetConnection>(InternetConnection.new);
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(connectivity: sl(), internetConnection: sl()),
  );

  // Restore persisted auth state into default headers once at app startup.
  sl<AuthSessionManager>().hydrateAccessTokenToHeader();
}
