class CotisationStatsEntity {
  final int? total;
  final int? paid;
  final int? notPaid;
  final int? novicesPaid;
  final int? novicesNotPaid;
  final int? anciensPaid;
  final int? anciensNotPaid;
  final int? doyenPaid;
  final int? doyenNotPaid;
  final double? paidPercentage;
  final double? notPaidPercentage;
  final double? novicesPaidPercentage;
  final double? novicesNotPaidPercentage;
  final double? anciensPaidPercentage;
  final double? anciensNotPaidPercentage;
  final double? doyensPaidPercentage;
  final double? doyensNotPaidPercentage;

  const CotisationStatsEntity({
    required this.total,
    required this.paid,
    required this.notPaid,
    required this.novicesPaid,
    required this.novicesNotPaid,
    required this.anciensPaid,
    required this.anciensNotPaid,
    required this.doyenPaid,
    required this.doyenNotPaid,
    required this.paidPercentage,
    required this.notPaidPercentage,
    required this.novicesPaidPercentage,
    required this.novicesNotPaidPercentage,
    required this.anciensPaidPercentage,
    required this.anciensNotPaidPercentage,
    required this.doyensPaidPercentage,
    required this.doyensNotPaidPercentage,
  });
}
