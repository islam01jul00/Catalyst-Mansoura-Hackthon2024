import 'package:flutter/material.dart';
import 'package:gdg_app/features/quiz/data/models/question/question.dart';

class QuestionHeader extends StatelessWidget {
  final Question question;
  const QuestionHeader({
    super.key,
    required this.question,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      question.question!,
      style: const TextStyle(
        fontSize: 20,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }
}
