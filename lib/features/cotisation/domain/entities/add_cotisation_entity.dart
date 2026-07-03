import 'package:equatable/equatable.dart';

class AddCotisationEntity extends Equatable {
  final int id;
  final double amount;
  final String year;

  const AddCotisationEntity({
    required this.id,
    required this.amount,
    required this.year,
  });

  @override
  List<Object?> get props => [id, amount, year];
}
