import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_base_project/shared/shared_pref.dart';
import 'package:objectbox/objectbox.dart';
import 'package:path/path.dart' as path;


class ObjectBoxService {
  static final ObjectBoxService _singleton = ObjectBoxService._internal();

  factory ObjectBoxService() {
    return _singleton;
  }

  ObjectBoxService._internal();

  static late Store store;

  static Future<void> deleteObjectBoxStore() async {
    final user = SharedPref.uid;
    final documentsDirectory = SharedPref.appPath;
    final directory = path.join(documentsDirectory, user);
    final objectBoxDirectory = Directory(directory);

    if (await objectBoxDirectory.exists()) {
      await objectBoxDirectory.delete(recursive: true);
      debugPrint("ObjectBox store deleted successfully.");
    } else {
      debugPrint("ObjectBox store directory does not exist.");
    }
  }


  static closeStore() {
    if (!store.isClosed()) {
      store.close();
    }
  }
}
