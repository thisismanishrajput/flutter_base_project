import 'package:clean_arch_base/src/core/di/modules/core_module_injection.dart';
import 'package:clean_arch_base/src/features/auth/di/auth_module_injection.dart';
import 'package:clean_arch_base/src/features/products/di/products_module_injection.dart';
import 'package:get_it/get_it.dart';

/// Global service locator.
final GetIt sl = GetIt.instance;

/// Registers external dependencies, core services, and feature modules.
Future<void> initDependencies() async {
  await initCoreModule(sl);
  initAuthModule(sl);
  initProductsModule(sl);
}
