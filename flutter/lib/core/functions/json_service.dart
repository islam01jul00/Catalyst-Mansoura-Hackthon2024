// convertJsonToModel(Map<String, dynamic> jsonData) {
//   for (var element in jsonData) {

//   }
//   return ;
// }

// Future<Map<String, dynamic>> fetchJsonData(
//     {required String endPoint,
//     required ApiConsumer apiConsumer,
//     Map<String, dynamic>? queryParameter}) async {
//   Map<String, dynamic>? queryParameters = {
//     ApiKeys.apiKey: Endpoints.apiKey,
//   };
//   if (queryParameter != null) {
//     queryParameters.addAll(queryParameter);
//   }
//   Map<String, dynamic> jsonData = await apiConsumer.get(
//       endPoint: endPoint, queryParameters: queryParameters);
//   return jsonData;
// }
