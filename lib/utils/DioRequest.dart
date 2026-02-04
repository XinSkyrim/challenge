// Secondary wrapper based on Dio

import 'package:dio/dio.dart';
import 'package:flutter_challenge/constants/index.dart';
import 'package:flutter_challenge/stores/TokenManager.dart';

class DioRequest {
  final _dio = Dio(); // Dio request instance

  // Base configuration interceptor
  DioRequest() {
    _dio.options
      ..baseUrl = GlobalConstants.BASE_URL
      ..connectTimeout = Duration(seconds: GlobalConstants.TIME_OUT)
      ..sendTimeout = Duration(seconds: GlobalConstants.TIME_OUT)
      ..receiveTimeout = Duration(seconds: GlobalConstants.TIME_OUT);

    // Add interceptors
    _addInterceptor();
  }

  // Register interceptors
  void _addInterceptor() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (request, handler) {

          if (tokenManager.getToken().isNotEmpty) {
            request.headers = {
              "Authorization": "Bearer ${tokenManager.getToken()}",
            };
          }
          handler.next(request);
        },
        onResponse: (response, handler) {

          if (response.statusCode! >= 200 && response.statusCode! < 300) {
            handler.next(response);
            return;
          }
          handler.reject(
            DioException(requestOptions: response.requestOptions),
          );
        },
        onError: (error, handler) {
          handler.reject(
            DioException(
              requestOptions: error.requestOptions,
              message: error.response?.data["msg"] ?? " ",
            ),
          );
        },
      ),
    );
  }

  Future<dynamic> get(String url, {Map<String, dynamic>? params}) {
    return _handleResponse(_dio.get(url, queryParameters: params));
  }

  // Define POST request
  Future<dynamic> post(String url, {Map<String, dynamic>? data}) {
    return _handleResponse(_dio.post(url, data: data));
  }

  // Further process the response result
  Future<dynamic> _handleResponse(Future<Response<dynamic>> task) async {
    try {
      Response<dynamic> res = await task;
      final data =
      res.data as Map<String, dynamic>;

      if (data["code"] == GlobalConstants.SUCCESS_CODE) {
        return data["result"];
      }

      // Throw business exception
      throw DioException(
        requestOptions: res.requestOptions,
        message: data["msg"] ?? "Failed to load data",
      );
    } catch (e) {
      rethrow;
    }
  }
}

// Singleton instance
final dioRequest = DioRequest();
