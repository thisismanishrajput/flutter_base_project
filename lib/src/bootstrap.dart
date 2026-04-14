import 'package:clean_arch_base/src/app.dart';
import 'package:clean_arch_base/src/core/config/app_environment.dart';
import 'package:clean_arch_base/src/core/di/injection_container.dart' as di;
import 'package:flutter/material.dart';

Future<void> bootstrap({
  required Flavor flavor,
  required String appName,
  required String baseUrl,
}) async {
  WidgetsFlutterBinding.ensureInitialized();
  AppEnvironment.init(flavor: flavor, appName: appName, baseUrl: baseUrl);
  await di.initDependencies();
  runApp(const App());
}
