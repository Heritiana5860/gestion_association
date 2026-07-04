import 'package:equatable/equatable.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/domain/entities/cotisation_inline_entity.dart';

class MemberEntity extends Equatable {
  final int? id;
  final String fullName;
  final String numberPhone;
  final bool isInside;
  final String cde;
  final String address;
  final String school;
  final String level;
  final String statut;
  final String? createdAt;
  final List<CotisationInlineEntity>? cotisations;

  const MemberEntity({
    this.id,
    required this.fullName,
    required this.numberPhone,
    required this.isInside,
    required this.cde,
    required this.address,
    required this.school,
    required this.level,
    required this.statut,
    this.createdAt,
    this.cotisations,
  });

  @override
  List<Object?> get props => [
    id,
    fullName,
    numberPhone,
    isInside,
    cde,
    address,
    school,
    level,
    statut,
    createdAt,
    cotisations,
  ];
}
