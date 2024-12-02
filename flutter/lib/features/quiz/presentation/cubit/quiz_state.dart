// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'quiz_cubit.dart';

abstract class QuizState {}

class QuizInitial extends QuizState {}

class GetQuestionLoading extends QuizState {}

class GetQuestionSuccess extends QuizState {
  List<Question> questions;
  GetQuestionSuccess({
    required this.questions,
  });
}

class GetQuestionFail extends QuizState {
  String errorMessage;
  GetQuestionFail({
    required this.errorMessage,
  });
}

class GetPersonalityLoading extends QuizState {}

class GetPersonalitySuccess extends QuizState {
  Personality personality;
  GetPersonalitySuccess({
    required this.personality,
  });
}

class GetPersonalityFail extends QuizState {
  String errorMessage;
  GetPersonalityFail({
    required this.errorMessage,
  });
}
