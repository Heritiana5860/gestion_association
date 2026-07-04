import 'package:equatable/equatable.dart';

class CotisationInlineEntity extends Equatable {
  final int? id;
  final String? year;
  final double amount;
  final bool isPaid;
  final String? paymentDate;

  const CotisationInlineEntity({
    this.id,
    this.year,
    required this.amount,
    required this.isPaid,
    this.paymentDate,
  });

  @override
  List<Object?> get props => [id, year, amount, isPaid, paymentDate];
}
