import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/domain/entities/cotisation_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/data/models/member_model.dart';

class CotisationModel extends CotisationEntity {
  const CotisationModel({
    required super.amount,
    required super.isUpdate,
    required super.year,
    required super.member,
    super.id,
    super.isPaid,
  });

  factory CotisationModel.fromJson(Map<String, dynamic> json) {
    return CotisationModel(
      amount: double.parse(json['amount']),
      isUpdate: json['is_updated'] as String,
      member: MemberModel.fromJson(json['member'] as Map<String, dynamic>),
      year: json['year'] as String,
      id: json['id'] as int?,
      isPaid: json['is_paid'] as bool,
    );
  }
}
