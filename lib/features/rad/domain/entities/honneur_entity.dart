import 'package:equatable/equatable.dart';

class HonneurEntity extends Equatable {
  final int? id;
  final String nom;
  final String fonction;
  final String contact;
  final String year;
  final String address;

  const HonneurEntity({
    required this.nom,
    required this.fonction,
    required this.contact,
    required this.year,
    required this.address,
    this.id,
  });

  @override
  List<Object?> get props => [id, nom, fonction, contact, year, address];
}
