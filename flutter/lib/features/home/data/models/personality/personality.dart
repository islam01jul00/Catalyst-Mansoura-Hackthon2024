import 'score.dart';

class Personality {
  String? personality;
  String? traits;
  Score? score;

  Personality({this.personality, this.traits, this.score});

  factory Personality.fromJson(Map<String, dynamic> json) => Personality(
        personality: json['personality'] as String?,
        traits: json['traits'] as String?,
        score: json['score'] == null
            ? null
            : Score.fromJson(json['score'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'personality': personality,
        'traits': traits,
        'score': score?.toJson(),
      };
}
