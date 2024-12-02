import 'option.dart';

class Question {
  String? id;
  String? question;
  List<Option>? options;
  String? aspect;

  Question({this.id, this.question, this.options, this.aspect});

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        id: json['id'] as String?,
        question: json['question'] as String?,
        options: (json['options'] as List<dynamic>?)
            ?.map((e) => Option.fromJson(e as Map<String, dynamic>))
            .toList(),
        aspect: json['aspect'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'question': question,
        'options': options?.map((e) => e.toJson()).toList(),
        'aspect': aspect,
      };
}
