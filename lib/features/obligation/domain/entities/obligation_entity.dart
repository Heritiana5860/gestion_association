import 'package:equatable/equatable.dart';

class ObligationEntity extends Equatable {
  final double noviceAmountIn;
  final double noviceAmountExt;
  final double doyenAncienIn;
  final double doyenAncienExt;
  final int year;

  const ObligationEntity({
    required this.noviceAmountIn,
    required this.noviceAmountExt,
    required this.doyenAncienIn,
    required this.doyenAncienExt,
    required this.year,
  });

  @override
  List<Object?> get props => [
    noviceAmountIn,
    noviceAmountExt,
    doyenAncienIn,
    doyenAncienExt,
  ];
}
