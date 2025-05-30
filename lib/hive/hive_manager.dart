// lib/utils/hive_manager.dart

import 'package:hive_flutter/hive_flutter.dart';

class HiveManager {
  static Future<void> initHive() async {
    try {
      await Hive.initFlutter(); // Initialize Hive
      await Hive.openBox('authBox'); // Box for auth/session
      await Hive.openBox('noticesBox'); // Box for notifications
      print('Hive initialized successfully.');
    } catch (e) {
      print('Hive initialization failed: $e');
    }
  }
}
