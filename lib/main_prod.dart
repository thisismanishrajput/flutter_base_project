import 'package:clean_arch_base/src/bootstrap.dart';
import 'package:clean_arch_base/src/core/config/app_environment.dart';

Future<void> main() async {
  await bootstrap(
    flavor: Flavor.prod,
    appName: 'Clean Arch Base',
    baseUrl: 'https://dummyjson.com',
  );
}
