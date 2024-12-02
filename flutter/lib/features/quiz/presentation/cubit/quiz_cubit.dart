import 'package:bloc/bloc.dart';
import 'package:gdg_app/features/home/data/models/personality/personality.dart';
import 'package:gdg_app/features/quiz/data/models/question/question.dart';
import 'package:gdg_app/features/quiz/data/repositories/quiz_repos.dart';

part 'quiz_state.dart';

class QuizCubit extends Cubit<QuizState> {
  QuizRepos quizRepos;
  List<Question> questions = [];
  QuizCubit({required this.quizRepos}) : super(QuizInitial());
  getQuestions() async {
    emit(GetQuestionLoading());
    var result = await quizRepos.getQuestions();
    result.fold(
        (failure) => emit(GetQuestionFail(errorMessage: failure.errorMessage)),
        (questions) {
      this.questions = questions;
      emit(GetQuestionSuccess(questions: questions));
    });
  }

  sendAnswers(
    Map<String, Map<String, String>> answers,
  ) async {
    emit(GetPersonalityLoading());
    var result = await quizRepos.sendAnswers(answers);
    result.fold(
        (failure) =>
            emit(GetPersonalityFail(errorMessage: failure.errorMessage)),
        (personality) => emit(GetPersonalitySuccess(personality: personality)));
  }
}
