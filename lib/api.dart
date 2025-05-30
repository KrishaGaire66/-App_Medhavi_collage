import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:medhavi/app/setting.dart';
import 'package:medhavi/errorfilter.dart';
import 'package:medhavi/hive/hive_key.dart';

class Api {
  static String login = 'auth/login';
  static String register = 'auth/register';
  static String getAssignment = 'assignment';



 static final Dio dio = Dio();
  static Map<String, String> headers() {
    // Open the box (make sure it's already opened during app initialization)
    final token = Hive.box(HiveKey.tokenKey)
            .get(HiveKey.tokenKey)
            ?.toString() ?? '';

    if (kDebugMode) {
      // You can log or debug token here if needed
      debugPrint('JWT Token: $token');
    }

    return {
      'Authorization': 'Bearer $token',
    };
  }




static Future<Map<String, dynamic>> delete({
    required String url,
    bool? useAuthToken,
    bool? useBaseUrl,
  }) async {
    try {
      final response = await dio.delete(
        ((useBaseUrl ?? true) ? AppSettings.baseUrl : '') + url,
        options: (useAuthToken ?? true)
            ? Options(
                contentType: 'multipart/form-data',
                headers: headers(),
              )
            : Options(
                contentType: 'multipart/form-data',
              ),
      );

      final resp = response.data;

      if (resp['error'] as bool? ?? false) {
        throw ApiException(resp['message'].toString());
      }

      return Map.from(resp as Map<dynamic, dynamic>? ?? {});
    } catch (e) {
      rethrow;
    }
  }

  static Future<Map<String, dynamic>> post({
    required String url,
    required Map<String, dynamic> parameter,
    Options? options,
    bool? useAuthToken,
    bool? useBaseUrl,
  }) async {
    try {
      final formData = FormData.fromMap(
        parameter,
        ListFormat.multiCompatible,
      );

      log('Request-API:$url  and $parameter ');
      final response = await dio.post(
        ((useBaseUrl ?? true) ? AppSettings.baseUrl : '') + url,
        data: formData,
        options: (useAuthToken ?? true)
            ? Options(
                contentType: 'multipart/form-data',
                headers: headers(),
              )
            : Options(
                contentType: 'multipart/form-data',
              ),
      );
      final resp = response.data;

      return Map.from(resp as Map<dynamic, dynamic>? ?? {});
    } on DioException catch (e) {
      // Handle DioException specifically
      if (e.response != null) {
        // Extract the error message from the response
        final errorMessage = e.response?.data['message'] ?? e.message;
        throw ApiException(errorMessage);
      } else {
        // If there's no response, just throw the message from the exception
        throw ApiException(e.message ?? 'An error occurred');
      }
    } on ApiException catch (e) {
      throw ApiException(e.errorMessage);
    } catch (e) {
      throw ApiException(e.toString());
    }
  }

  static Future<Map<String, dynamic>> get({
    required String url,
    bool? useAuthToken,
    Map<String, dynamic>? queryParameters,
    bool? useBaseUrl,
  }) async {
    try {
      final response = await dio.get(
        ((useBaseUrl ?? true) ? AppSettings.baseUrl : '') + url,
        queryParameters: queryParameters,
        options: (useAuthToken ?? true) ? Options(headers: headers()) : null,
      );
      return Map.from(response.data as Map<dynamic, dynamic>? ?? {});
    } on DioException catch (e) {
      // Handle DioException specifically
      if (e.response != null) {
        // Extract the error message from the response
        final errorMessage = e.response?.data['message'] ?? e.message;
        throw ApiException(errorMessage);
      } else {
        // If there's no response, just throw the message from the exception
        throw ApiException(e.message ?? 'An error occurred');
      }
    } on ApiException catch (e) {
      throw ApiException(e.errorMessage);
    } catch (e) {
      throw ApiException(e.toString());
    }
  }
}







class ApiException implements Exception {
  ApiException(this.errorMessage);

  dynamic errorMessage;

  @override
  String toString() {
    return ErrorFilter.check(errorMessage).error;
  }
}
