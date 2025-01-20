import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_base_project/core/app.dart';
import '../services/service_locator.dart' as service_locator;

Future<void> initializeApp() async {
  setOrientation();
  final flavor = await getFlavor();
  await dotenv.load(fileName: 'env.$flavor');
  await service_locator.init();
  await service_locator.initDB();
  runApp(const MyApp());
  logEnvironment(flavor);
}
void handleCrashErrors(Object error, StackTrace stack) {
  debugPrint('error Title:- $error');
  debugPrintStack(stackTrace: stack);
  if (!kIsWeb) {
    // FirebaseCrashlytics.instance.recordError(
    //   error,
    //   stack,
    //   fatal: true,
    // );
  }
}
void setOrientation() {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
}


void logEnvironment(String env) {
  debugPrint('===============> Running in "$env" Environment <===============');
}


Future<String> getFlavor() async {
  return await getMobileFlavor();
}

Future<String> getMobileFlavor() async {
  String? flavor;
  try {
    flavor = await const MethodChannel('flavor_channel')
        .invokeMethod<String>('getFlavor');
  } catch (e, st) {
    debugPrint(e.toString());
    debugPrintStack(stackTrace: st);
  }

  return flavor ?? "prod";
}
