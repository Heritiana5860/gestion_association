
class MemberEntity {
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
  });
}
