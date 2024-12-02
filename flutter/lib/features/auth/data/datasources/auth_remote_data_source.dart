import 'package:gdg_app/core/api/api_consumer.dart';
import 'package:gdg_app/core/api/endpoint.dart';
import 'package:gdg_app/core/cached_helper/secure_cache.dart';
import 'package:gdg_app/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login({
    required String email,
    required String password,
  });
  Future<UserModel> register({
    required String email,
    required String password,
    required String name,
    required String gender,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiConsumer apiConsumer;

  AuthRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<UserModel> login(
      {required String email, required String password}) async {
    Map<String, dynamic> jsonData = await apiConsumer.post(
        endPoint: Endpoints.login,
        data: {ApiKeys.email: email, ApiKeys.password: password},
        isFormData: true);
    UserModel userModel = UserModel.fromJson(jsonData[ApiKeys.data]);
    await saveDataLocally(value: userModel.token!);
    return userModel;
  }

  @override
  Future<UserModel> register({
    required String email,
    required String password,
    required String name,
    required String gender,
  }) async {
    Map<String, dynamic> jsonData = await apiConsumer.post(
        endPoint: Endpoints.register,
        data: {
          ApiKeys.email: email,
          ApiKeys.password: password,
          ApiKeys.name: name,
          ApiKeys.gender: gender,
        },
        isFormData: true);
    UserModel userModel = UserModel.fromJson(jsonData);
    await saveDataLocally(value: userModel.token!);
    return userModel;
  }
}

Future<void> saveDataLocally({required String value}) async {
  await CachedSecure.saveToken(value);
}
