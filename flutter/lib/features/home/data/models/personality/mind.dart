class Mind {
  int? intuitive;
  int? observant;

  Mind({this.intuitive, this.observant});

  factory Mind.fromJson(Map<String, dynamic> json) => Mind(
        intuitive: json['Intuitive'] as int?,
        observant: json['Observant'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'Intuitive': intuitive,
        'Observant': observant,
      };
}
