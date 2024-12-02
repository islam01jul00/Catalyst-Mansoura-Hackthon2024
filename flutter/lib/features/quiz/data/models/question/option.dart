class Option {
  String? answer;
  String? text;

  Option({this.answer, this.text});

  factory Option.fromJson(Map<String, dynamic> json) => Option(
        answer: json['answer'] as String?,
        text: json['text'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'answer': answer,
        'text': text,
      };
}
