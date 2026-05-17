import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/domain/entities/cotisation_stats_entity.dart';

class CotisationStatsModel extends CotisationStatsEntity {
  const CotisationStatsModel({
    required super.total,
    required super.paid,
    required super.notPaid,
    required super.novicesPaid,
    required super.novicesNotPaid,
    required super.anciensPaid,
    required super.anciensNotPaid,
    required super.doyenPaid,
    required super.doyenNotPaid,
    required super.paidPercentage,
    required super.notPaidPercentage,
    required super.novicesPaidPercentage,
    required super.novicesNotPaidPercentage,
    required super.anciensPaidPercentage,
    required super.anciensNotPaidPercentage,
    required super.doyensPaidPercentage,
    required super.doyensNotPaidPercentage,
  });

  factory CotisationStatsModel.fromJson(Map<String, dynamic> json) {
    return CotisationStatsModel(
      total: json['total'] as int? ?? 0,
      paid: json['paid'] as int? ?? 0,
      notPaid: json['not_paid'] as int? ?? 0,
      novicesPaid: json['novices_paid'] as int? ?? 0,
      novicesNotPaid: json['novices_not_paid'] as int? ?? 0,
      anciensPaid: json['anciens_paid'] as int? ?? 0,
      anciensNotPaid: json['anciens_not_paid'] as int? ?? 0,
      doyenPaid: json['doyens_paid'] as int? ?? 0,
      doyenNotPaid: json['doyens_not_paid'] as int? ?? 0,
      paidPercentage: (json['paid_percentage'] as num? ?? 0.0).toDouble(),
      notPaidPercentage: (json['not_paid_percentage'] as num? ?? 0.0)
          .toDouble(),
      novicesPaidPercentage: (json['novices_paid_percentage'] as num? ?? 0.0)
          .toDouble(),
      novicesNotPaidPercentage:
          (json['novices_not_paid_percentage'] as num? ?? 0.0).toDouble(),
      anciensPaidPercentage: (json['anciens_paid_percentage'] as num? ?? 0.0)
          .toDouble(),
      anciensNotPaidPercentage:
          (json['anciens_not_paid_percentage'] as num? ?? 0.0).toDouble(),
      doyensPaidPercentage: (json['doyens_paid_percentage'] as num? ?? 0.0)
          .toDouble(),
      doyensNotPaidPercentage:
          (json['doyens_not_paid_percentage'] as num? ?? 0.0).toDouble(),
    );
  }
}
