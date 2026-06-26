import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/entities/college_entity.dart';

class CollegeModel extends CollegeEntity {
  const CollegeModel({
    super.id,
    required super.nom,
    required super.contact,
    required super.address,
    required super.etablissement,
    required super.niveau,
    required super.nomPromotion,
    required super.year,
  });

  factory CollegeModel.fromJson(Map<String, dynamic> json) {
    return CollegeModel(
      id: json['id'] as int?,
      nom: json['nom'] as String,
      contact: json['contact'] as String,
      address: json['address'] as String,
      etablissement: json['etablissement'] as String,
      niveau: json['niveau'] as String,
      nomPromotion: json['nom_promotion'] as String,
      year: json['year'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nom': nom,
      'contact': contact,
      'address': address,
      'etablissement': etablissement,
      'niveau': niveau,
      'nom_promotion': nomPromotion,
      'year': year,
    };
  }
}
