import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gdg_app/core/utils/color.dart';
import 'package:gdg_app/features/quiz/data/models/question/question.dart';
import 'package:gdg_app/features/quiz/presentation/cubit/quiz_cubit.dart';

class QuizView extends StatefulWidget {
  const QuizView({super.key});

  @override
  _QuizViewState createState() => _QuizViewState();
}

class _QuizViewState extends State<QuizView> {
  final PageController _pageController = PageController();
  late List<Question> _questions;
  int _currentIndex = 0;
  final Map<String, String?> _selectedAnswers = {}; // Updated to a map

  @override
  void initState() {
    super.initState();
    _questions = BlocProvider.of<QuizCubit>(context).questions;

    // Initialize map with question IDs
    for (var question in _questions) {
      _selectedAnswers[question.id!] = null;
    }
  }

  void _navigateToNext() {
    if (_currentIndex < _questions.length - 1) {
      setState(() {
        _currentIndex++;
      });
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _showResults();
    }
  }

  void _navigateToPrevious() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
      });
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pop(context);
    }
  }

  void _showResults() {
    // Format responses
    final Map<String, String> responses = _selectedAnswers.map(
      (key, value) => MapEntry(key, value ?? ""),
    );

    final Map<String, Map<String, String>> answers = {
      "responses": responses,
    };

    // Submit answers using the QuizCubit
    BlocProvider.of<QuizCubit>(context).sendAnswers(answers);

    // Show confirmation dialog
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Quiz Completed"),
          content: const Text("Your answers have been submitted."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                Navigator.pop(context); // Navigate back
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizCubit, QuizState>(
      builder: (context, state) {
        if (state is GetQuestionFail) {
          return Scaffold(
            body: Center(
              child: Text(state.errorMessage),
            ),
          );
        } else if (state is GetQuestionSuccess) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: _currentIndex != 0
                  ? GestureDetector(
                      onTap: _navigateToPrevious,
                      child: Icon(Icons.arrow_back_ios,
                          color: ColorManager.blackColor),
                    )
                  : null,
            ),
            backgroundColor: Colors.white,
            body: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 20.0.h),
              child: Column(
                children: [
                  // Progress bar
                  LinearProgressIndicator(
                    value: (_currentIndex + 1) / _questions.length,
                    backgroundColor: Colors.grey.shade300,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(ColorManager.blackColor),
                  ),
                  SizedBox(height: 30.h),

                  // Question Header
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _questions.length,
                      itemBuilder: (context, index) {
                        return buildQuestion(_questions[index]);
                      },
                    ),
                  ),

                  // Next Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _navigateToNext,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorManager.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 16.0.h),
                      ),
                      child: Text(
                        _currentIndex == _questions.length - 1
                            ? 'Finish'
                            : 'Next',
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  Widget buildQuestion(Question question) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 20.h),
        // Question Text
        Text(
          question.question!,
          style: TextStyle(
            fontSize: 20.sp,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 40.h),

        // Options
        ...question.options!.asMap().entries.map((entry) {
          final optionIndex = entry.key;
          final option = entry.value;
          final isSelected = _selectedAnswers[question.id] == option.text;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedAnswers[question.id!] = option.text;
              });
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
              width: double.infinity,
              decoration: BoxDecoration(
                color: isSelected
                    ? ColorManager.primaryColor
                    : ColorManager.hintColor.withOpacity(.18),
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                  color: isSelected
                      ? ColorManager.primaryColor
                      : const Color.fromARGB(255, 245, 245, 245),
                ),
              ),
              child: Text(
                option.text!,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: isSelected ? Colors.white : Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }).toList(),
      ],
    );
  }
}
