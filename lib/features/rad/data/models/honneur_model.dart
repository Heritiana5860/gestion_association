import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/entities/honneur_entity.dart';

class HonneurModel extends HonneurEntity {
  const HonneurModel({
    required super.nom,
    required super.fonction,
    required super.contact,
    required super.year,
    required super.address,
  });

  factory HonneurModel.fromJson(Map<String, dynamic> json) {
    return HonneurModel(
      nom: json['nom'] as String,
      fonction: json['fonction'] as String,
      contact: json['contact'] as String,
      year: json['year'] as String,
      address: json['address'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nom': nom,
      'fonction': fonction,
      'contact': contact,
      'year': year,
      'address': address,
    };
  }
}
