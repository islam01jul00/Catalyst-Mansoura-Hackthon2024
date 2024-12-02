class Tactics {
  int? judging;
  int? prospecting;

  Tactics({this.judging, this.prospecting});

  factory Tactics.fromJson(Map<String, dynamic> json) => Tactics(
        judging: json['Judging'] as int?,
        prospecting: json['Prospecting'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'Judging': judging,
        'Prospecting': prospecting,
      };
}
