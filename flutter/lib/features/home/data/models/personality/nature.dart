class Nature {
  int? thinking;
  int? feeling;

  Nature({this.thinking, this.feeling});

  factory Nature.fromJson(Map<String, dynamic> json) => Nature(
        thinking: json['Thinking'] as int?,
        feeling: json['Feeling'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'Thinking': thinking,
        'Feeling': feeling,
      };
}
