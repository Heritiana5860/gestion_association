import 'package:login_with_unite_test_and_clean_architecture/features/member/domain/entities/member_entity.dart';

class CotisationEntity {
  final int? id;
  final double amount;
  final String isUpdate;
  final String year;
  final MemberEntity member;

  const CotisationEntity({
    required this.amount,
    required this.isUpdate,
    required this.year,
    required this.member,
    this.id,
  });
}
