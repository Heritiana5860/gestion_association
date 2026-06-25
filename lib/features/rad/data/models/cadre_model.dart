import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/entities/cadre_entity.dart';

class CadreModel extends CadreEntity {
  const CadreModel({
    required super.nom,
    required super.fonction,
    required super.contact,
    required super.address,
  });

  factory CadreModel.fromJson(Map<String, dynamic> json) {
    return CadreModel(
      nom: json['nom'] as String,
      fonction: json['fonction'] as String,
      contact: json['contact'] as String,
      address: json['address'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nom': nom,
      'fonction': fonction,
      'contact': contact,
      'address': address,
    };
  }
}
