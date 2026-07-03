import 'package:equatable/equatable.dart';

class CadreEntity extends Equatable {
  final int? id;
  final String nom;
  final String fonction;
  final String contact;
  final String address;

  const CadreEntity({
    required this.nom,
    required this.fonction,
    required this.contact,
    required this.address,
    this.id,
  });

  @override
  List<Object?> get props => [id, nom, fonction, contact, address];
}
