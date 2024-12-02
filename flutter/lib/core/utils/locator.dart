import 'package:dio/dio.dart';
import 'package:gdg_app/core/api/dio_consumer.dart';
import 'package:gdg_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:gdg_app/features/auth/data/repositories/auth_repo.dart';
import 'package:gdg_app/features/quiz/data/datasources/quiz_data_source.dart';
import 'package:gdg_app/features/quiz/data/repositories/quiz_repos.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<DioConsumer>(
    DioConsumer(
      dio: Dio(),
    ),
  );
  getIt.registerSingleton<AuthRepoImpl>(
    AuthRepoImpl(
      authRemoteDataSource: AuthRemoteDataSourceImpl(
        apiConsumer: getIt.get<DioConsumer>(),
      ),
    ),
  );
  getIt.registerSingleton<QuizReposImpl>(
    QuizReposImpl(
      dataSource: QuizDataSourceImpl(
        apiConsumer: getIt.get<DioConsumer>(),
      ),
    ),
  );
}
