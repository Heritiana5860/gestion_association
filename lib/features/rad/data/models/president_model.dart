import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/entities/president_entity.dart';

class PresidentModel extends PresidentEntity {
  const PresidentModel({
    required super.nom,
    required super.contact,
    required super.year,
    required super.bio,
    super.id,
  });

  factory PresidentModel.fromJson(Map<String, dynamic> json) {
    return PresidentModel(
      id: json['id'] as int?,
      nom: json['nom'] as String,
      contact: json['contact'] as String,
      year: json['year'] as String,
      bio: json['bio'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'nom': nom, 'contact': contact, 'year': year, 'bio': bio};
  }
}
