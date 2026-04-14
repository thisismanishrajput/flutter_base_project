import 'package:clean_arch_base/src/bootstrap.dart';
import 'package:clean_arch_base/src/core/config/app_environment.dart';

Future<void> main() async {
  await bootstrap(
    flavor: Flavor.dev,
    appName: 'Clean Arch Base Dev',
    baseUrl: 'https://dummyjson.com',
  );
}
