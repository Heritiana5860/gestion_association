import 'package:login_with_unite_test_and_clean_architecture/features/material/domain/entities/material_entity.dart';

class MaterialModel extends MaterialEntity {
  const MaterialModel({
    required super.nom,
    super.description,
    super.nombreMateriel,
    super.id,
  });

  factory MaterialModel.fromJson(Map<String, dynamic> json) {
    return MaterialModel(
      nom: json['nom'] as String,
      description: json['description'] as String?,
      nombreMateriel: json['nombre_materiel'] as int?,
      id: json['id'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nom': nom,
      'description': description,
      'nombre_materiel': nombreMateriel,
    };
  }
}
