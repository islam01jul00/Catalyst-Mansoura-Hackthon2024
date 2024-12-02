import 'energy.dart';
import 'identity.dart';
import 'mind.dart';
import 'nature.dart';
import 'tactics.dart';

class Score {
  Energy? energy;
  Mind? mind;
  Nature? nature;
  Tactics? tactics;
  Identity? identity;

  Score({this.energy, this.mind, this.nature, this.tactics, this.identity});

  factory Score.fromJson(Map<String, dynamic> json) => Score(
        energy: json['Energy'] == null
            ? null
            : Energy.fromJson(json['Energy'] as Map<String, dynamic>),
        mind: json['Mind'] == null
            ? null
            : Mind.fromJson(json['Mind'] as Map<String, dynamic>),
        nature: json['Nature'] == null
            ? null
            : Nature.fromJson(json['Nature'] as Map<String, dynamic>),
        tactics: json['Tactics'] == null
            ? null
            : Tactics.fromJson(json['Tactics'] as Map<String, dynamic>),
        identity: json['Identity'] == null
            ? null
            : Identity.fromJson(json['Identity'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'Energy': energy?.toJson(),
        'Mind': mind?.toJson(),
        'Nature': nature?.toJson(),
        'Tactics': tactics?.toJson(),
        'Identity': identity?.toJson(),
      };
}
