class MemberStatsEntity {
  final int total;
  final int novices;
  final int anciens;
  final int doyens;
  final double novicesPourcentage;
  final double anciensPourcentage;
  final double doyensPourcantage;

  const MemberStatsEntity({
    required this.total,
    required this.novices,
    required this.anciens,
    required this.doyens,
    required this.novicesPourcentage,
    required this.anciensPourcentage,
    required this.doyensPourcantage,
  });
}
