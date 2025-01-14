import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_project/core/initialize_app.dart';
import 'package:flutter_base_project/services/session_manager/app_session_manager.dart';

Future<void> main() async {
  runZonedGuarded(() async {
      WidgetsFlutterBinding.ensureInitialized();
      WidgetsFlutterBinding.ensureInitialized();
      // Initialize Firebase SDK
      await Firebase.initializeApp();
      await AppSessionManager.instance.init();

      await initializeApp();
    },
    handleCrashErrors,
  );
}
