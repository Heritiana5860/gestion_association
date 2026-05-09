import 'package:login_with_unite_test_and_clean_architecture/features/member/domain/entities/member_stats_entity.dart';

class MemberStatsModel extends MemberStatsEntity {
  const MemberStatsModel({
    required super.total,
    required super.novices,
    required super.anciens,
    required super.doyens,
    required super.novicesPourcentage,
    required super.anciensPourcentage,
    required super.doyensPourcantage,
  });

  factory MemberStatsModel.fromJson(Map<String, dynamic> json) {
    return MemberStatsModel(
      total: json['total'] as int,
      novices: json['novices'] as int,
      anciens: json['anciens'] as int,
      doyens: json['doyens'] as int,
      novicesPourcentage: json['novices_percentage'] as double,
      anciensPourcentage: json['anciens_percentage'] as double,
      doyensPourcantage: json['doyens_percentage'] as double,
    );
  }
}
