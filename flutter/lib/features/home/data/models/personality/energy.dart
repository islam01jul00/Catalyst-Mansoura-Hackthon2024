class Energy {
  int? introverted;
  int? extraverted;

  Energy({this.introverted, this.extraverted});

  factory Energy.fromJson(Map<String, dynamic> json) => Energy(
        introverted: json['Introverted'] as int?,
        extraverted: json['Extraverted'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'Introverted': introverted,
        'Extraverted': extraverted,
      };
}
