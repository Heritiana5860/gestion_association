import 'package:login_with_unite_test_and_clean_architecture/features/obligation/domain/entities/obligation_entity.dart';

class ObligationModel extends ObligationEntity {
  const ObligationModel({
    required super.noviceAmountIn,
    required super.noviceAmountExt,
    required super.doyenAncienIn,
    required super.doyenAncienExt,
    required super.year,
  });

  factory ObligationModel.fromJson(Map<String, dynamic> json) {
    return ObligationModel(
      doyenAncienExt: double.parse(json['adhasion_annuel_novice_ext']),
      doyenAncienIn: double.parse(json['doyen_ancien_in']),
      noviceAmountExt: double.parse(json['adhasion_annuel_novice_ext']),
      noviceAmountIn: double.parse(json['adhasion_annuel_novice_in']),
      year: json['year'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'doyen_ancien_amount_outside': doyenAncienExt,
      'doyen_ancien_amount_inside': doyenAncienIn,
      'novice_amount_outside': noviceAmountExt,
      'novice_amount_inside': noviceAmountIn,
      'year': year,
    };
  }
}
