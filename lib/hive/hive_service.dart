import 'package:hive/hive.dart';
import 'package:medhavi/hive/hive_key.dart';

class HiveService {


  // Initialize Hive
  static Future<void> init() async {
    await Hive.openBox(HiveKey.authBox);
    await Hive.openBox(HiveKey.noticeKey);
  }

  // Save data to Hive

  static Future<void> saveData(String key, dynamic value) async {
    final box = Hive.box(HiveKey.authBox);
    await box.put(key, value);
  }

  // Read data from Hive
  static dynamic getData(String key) {
    final box = Hive.box(HiveKey.authBox);
    return box.get(key);
  }

  // Delete data from Hive
  static Future<void> deleteData(String key) async {
    final box = Hive.box(HiveKey.authBox);
    await box.delete(key);
  }

  // Clear all data from Hive
  static Future<void> clearData() async {
    final box = Hive.box(HiveKey.authBox);
    await box.clear();
  }

  // Check if user is logged in
  static bool isLoggedIn() {
    final box = Hive.box(HiveKey.authBox);
    return box.get(HiveKey.tokenKey) != null;
  }

  // Logout
  static Future<void> logout() async {
    await clearData();
  }
}
