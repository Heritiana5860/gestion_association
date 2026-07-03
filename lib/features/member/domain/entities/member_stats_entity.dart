import 'package:equatable/equatable.dart';

class MemberStatsEntity extends Equatable {
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

  @override
  List<Object?> get props => [
    total,
    novices,
    anciens,
    doyens,
    novicesPourcentage,
    anciensPourcentage,
    doyensPourcantage,
  ];
}
