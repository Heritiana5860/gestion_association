import 'package:equatable/equatable.dart';

class PresidentEntity extends Equatable {
  final int? id;
  final String nom;
  final String contact;
  final String year;
  final String bio;

  const PresidentEntity({
    required this.nom,
    required this.contact,
    required this.year,
    required this.bio,
    this.id,
  });

  @override
  List<Object?> get props => [id, nom, contact, year, bio];
}
