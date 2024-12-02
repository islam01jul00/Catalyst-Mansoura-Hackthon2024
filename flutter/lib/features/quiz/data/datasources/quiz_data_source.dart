// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:gdg_app/core/api/api_consumer.dart';
import 'package:gdg_app/core/api/endpoint.dart';
import 'package:gdg_app/features/home/data/models/personality/personality.dart';
import 'package:gdg_app/features/quiz/data/models/question/question.dart';

abstract class QuizDataSource {
  Future<List<Question>> getQuestions();
  Future<Personality> sendAnswers(Map<String, Map<String, String>> answers); //{"id":1,}
}

class QuizDataSourceImpl extends QuizDataSource {
  ApiConsumer apiConsumer;
  QuizDataSourceImpl({
    required this.apiConsumer,
  });
  @override
  Future<List<Question>> getQuestions() async {
    Map<String, dynamic> json =
        await apiConsumer.get(endPoint: Endpoints.question);
    List<dynamic> questionsJson = json["questions"];
    List<Question> questions = [];
    for (var question in questionsJson) {
      questions.add(Question.fromJson(question));
    }
    return questions;
  }

  @override
  Future<Personality> sendAnswers(Map<String, Map<String, String>> answers) async {
    Map<String, dynamic> json =
        await apiConsumer.post(endPoint: Endpoints.question, data: answers);
    return Personality.fromJson(json);
  }
}
