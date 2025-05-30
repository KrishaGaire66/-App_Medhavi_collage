import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:medhavi/hive/hive_service.dart';
import 'package:medhavi/models/auth_model.dart';
import 'package:medhavi/utils/device_info.dart';

class ApiService {
  final Dio dio = Dio(BaseOptions(baseUrl: "https://hsj.com.np/api/auth"));
  final Box _authBox = Hive.box('authBox');

  /// Logs in the user and returns a `Welcome` instance on success.
  Future<Welcome?> loginWithApi(String email, String password) async {
    final deviceName = await getDeviceName();
    try {
      final response = await dio.post(
        '/login',
        queryParameters: {
          "email": email,
          "password": password,
          "device_name": deviceName,
        },
      );

      print("Response data: ${response.data}");
      if (response.data != null) {
        Welcome welcomeData;

        if (response.data is String) {
          final decodedData = jsonDecode(response.data);
          welcomeData = Welcome.fromJson(decodedData);
        } else {
          welcomeData = Welcome.fromJson(response.data);
        }

        // ✅ Save token correctly
        await HiveService.saveData('token', welcomeData.accessToken);
        await HiveService.saveData('email', welcomeData.user.email);
        await HiveService.saveData('name', welcomeData.user.firstName);
        print("Token saved: ${welcomeData.accessToken}");
        print("Login Successful: ${welcomeData.user.firstName}");
        return welcomeData;
      } else {
        print('Login failed: ${response.data}');
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<bool> signUpWithApi(
    String name,
    String email,
    String password,
    String phone,
    String userType,
  ) async {
    try {
      final response = await dio.post(
        '/register',
        data: {
          "first_name": name,
          "last_name": name,
          "email": email,
          "password": password,
          "term": 1,
        },
      );

      print("Signup Response data: ${response.data}");

      if (response.data != null && response.data['status'] == true) {
        // Call the login API to get the token
        final res = await loginWithApi(email, password);

        // Save token to Hive if it is not null
        if (res != null && res.accessToken != null) {
        await HiveService.saveData('token', res.accessToken);
await HiveService.saveData('name', name); // ✅ Save the name to Hive
        await HiveService.saveData('email', email); // Optional
        await HiveService.saveData('phone', phone); // Optional
          print("Token saved in Hive: ${res.accessToken}");
          return true; // ✅ Return true if everything is successful
        } else {
          print("Failed to login after registration");
          return false; // ✅ Return false if login fails
        }
      } else {
        print("Signup failed: ${response.data}");
        return false; // ✅ Return false if signup response is not valid
      }
    } catch (e) {
      print("Sign Up Error: $e");
      return false; // ✅ Return false if there's an exception
    }
  }
}
