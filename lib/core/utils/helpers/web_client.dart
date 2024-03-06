import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../configs/app_config.dart';

class WebClient {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: AppConfig.baseUrl,
    ),
  );

  static get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    String? headerToken,
  }) async {
    try {
      final response = await _dio.get(
        endpoint,
        queryParameters: queryParameters,
        options: Options(
          headers: {"authorization": "Bearer $headerToken"},
        ),
      );

      return response;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception("Connection Timeout Exception");
      }
      throw Exception(e.message);
    }
  }

  static post(
    String endpoint, {
    Map<String, dynamic>? data,
    String? headerToken,
  }) async {
    try {
      final response = await _dio.post(
        endpoint,
        data: data,
        options: Options(
          headers: {"authorization": "Bearer $headerToken"},
        ),
      );

      return response;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  static patch(
    String endpoint, {
    Map<String, dynamic>? data,
    String? headerToken,
  }) async {
    try {
      final response = await _dio.patch(
        endpoint,
        data: data,
        options: Options(
          headers: {"authorization": "Bearer $headerToken"},
        ),
      );

      return response;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  static Future<Response> put(String endpoint, {Object? data}) async {
    try {
      final response = await _dio.put(endpoint, data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  static Future<Response> delete(
    String endpoint, {
    Map<String, dynamic>? data,
    String? headerToken,
  }) async {
    try {
      final response = await _dio.delete(
        endpoint,
        data: data,
        options: Options(
          headers: {"authorization": "Bearer $headerToken"},
        ),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  static postFormData(
    String endpoint, {
    FormData? data,
    String? headerToken,
  }) async {
    try {
      final response = await _dio.post(
        endpoint,
        data: data,
        options: Options(
          headers: {"authorization": "Bearer $headerToken"},
        ),
      );

      return response;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
