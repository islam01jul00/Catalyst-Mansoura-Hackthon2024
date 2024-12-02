abstract class ApiConsumer {
  Future get({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
  });
  Future delete({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
  });
  Future post({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    bool isFormData = false,
  });
  Future put({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    bool isFormData = false,
  });
  Future patch({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    bool isFormData = false,
  });
}
