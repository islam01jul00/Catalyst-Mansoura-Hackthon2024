import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:gdg_app/core/errors/failure.dart';
import 'package:gdg_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:gdg_app/features/auth/data/models/user_model.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserModel>> login({
    required String email,
    required String password,
  });
  Future<Either<Failure, UserModel>> register({
    required String email,
    required String password,
    required String name,
    required String gender,
  });
}

class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepoImpl({required this.authRemoteDataSource});

  @override
  Future<Either<Failure, UserModel>> login(
      {required String email, required String password}) async {
    try {
      UserModel userModel = await authRemoteDataSource.login(
        email: email,
        password: password,
      );
      return right(userModel);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioException(e));
    } catch (e) {
      return left(ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel>> register({
    required String email,
    required String password,
    required String name,
    required String gender,
  }) async {
    try {
      UserModel userModel = await authRemoteDataSource.register(
        email: email,
        password: password,
        name: name,
        gender: gender,
      );
      return right(userModel);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioException(e));
    } catch (e) {
      return left(ServerFailure(errorMessage: e.toString()));
    }
  }
}
