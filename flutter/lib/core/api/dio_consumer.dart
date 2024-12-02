import 'package:dio/dio.dart';
import 'package:gdg_app/core/cached_helper/secure_cache.dart';
import 'api_consumer.dart';

class DioConsumer implements ApiConsumer {
  final Dio dio;
  DioConsumer({
    required this.dio,
  }) {
    String? token;
    dio.options.baseUrl = "http://192.168.146.66:8000";
    // if (token != null) {
    //   dio.options.headers['Authorization'] = 'Bearer $token';
    // }
    // dio.options.headers['Cache-Control'] = 'no-cache';
    dio.options.headers['Accept'] = '*/*';
    // dio.options.headers['Accept-Encoding'] = 'gzip, deflate, br';
    // dio.options.headers['Connection'] = 'keep-alive';
    dio.options.headers['Content-Type'] = 'application/json';
    dio.interceptors.add(
      LogInterceptor(
        requestHeader: true,
        responseHeader: true,
        responseBody: true,
        request: true,
        error: true,
        requestBody: true,
      ),
    );
  }

  @override
  Future delete(
      {required String endPoint,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? data}) async {
    Response response = await dio.delete(
      endPoint,
      queryParameters: queryParameters,
      data: data,
    );
    return response.data;
  }

  @override
  Future get({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
  }) async {
    Response response = await dio.get(
      endPoint,
      queryParameters: queryParameters,
      data: data,
    );
    return response.data;
  }

  @override
  Future patch({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    bool isFormData = false,
  }) async {
    Response response = await dio.patch(
      endPoint,
      queryParameters: queryParameters,
      data: isFormData ? FormData.fromMap(data!) : data,
    );
    return response.data;
  }

  @override
  Future post({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    bool isFormData = false,
  }) async {
    Response response = await dio.post(
      endPoint,
      queryParameters: queryParameters,
      data: data,
    );
    return response.data;
  }

  @override
  Future put({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    bool isFormData = false,
  }) async {
    Response response = await dio.put(
      endPoint,
      queryParameters: queryParameters,
      data: isFormData ? FormData.fromMap(data!) : data,
    );
    return response.data;
  }
}

getToken() async {
  return await CachedSecure.getToken();
}
