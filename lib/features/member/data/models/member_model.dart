import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/data/models/cotisation_inline_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/domain/entities/member_entity.dart';

class MemberModel extends MemberEntity {
  const MemberModel({
    super.id,
    required super.fullName,
    required super.numberPhone,
    required super.isInside,
    required super.cde,
    super.address,
    super.school,
    super.level,
    required super.statut,
    super.createdAt,
    super.cotisations,
  });

  factory MemberModel.fromJson(Map<String, dynamic> json) {
    return MemberModel(
      id: json['id'] as int?,
      fullName: json['full_name'] as String,
      numberPhone: json['number_phone'] as String,
      isInside: json['is_inside'] as bool,
      cde: json['cde'] as String,
      address: json['address'] as String?,
      school: json['school'] as String?,
      level: json['level'] as String?,
      statut: json['statut'] as String,
      createdAt: json['created_at'] as String?,
      cotisations: (json['cotisations'] as List<dynamic>)
          .map((e) => CotisationInlineModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'full_name': fullName,
      'number_phone': numberPhone,
      'is_inside': isInside,
      'cde': cde,
      'address': address,
      'school': school,
      'level': level,
      'statut': statut,
    };
  }
}
