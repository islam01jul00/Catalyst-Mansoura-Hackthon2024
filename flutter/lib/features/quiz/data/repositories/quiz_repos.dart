// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:gdg_app/core/errors/failure.dart';
import 'package:gdg_app/features/home/data/models/personality/personality.dart';
import 'package:gdg_app/features/quiz/data/datasources/quiz_data_source.dart';
import 'package:gdg_app/features/quiz/data/models/question/question.dart';

abstract class QuizRepos {
  Future<Either<Failure, List<Question>>> getQuestions();
  Future<Either<Failure, Personality>> sendAnswers(
      Map<String, Map<String, String>> answers); //{"id":1,}
}

class QuizReposImpl extends QuizRepos {
  QuizDataSource dataSource;
  QuizReposImpl({
    required this.dataSource,
  });
  @override
  Future<Either<Failure, List<Question>>> getQuestions() async {
    try {
      List<Question> questions = await dataSource.getQuestions();
      return right(questions);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioException(e));
    } catch (e) {
      return left(ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Personality>> sendAnswers(
      Map<String, Map<String, String>> answers) async {
    try {
      Personality personality = await dataSource.sendAnswers(answers);
      return right(personality);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioException(e));
    } catch (e) {
      return left(ServerFailure(errorMessage: e.toString()));
    }
  }
}
