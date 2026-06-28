import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/domain/entities/add_cotisation_entity.dart';

class AddCotisationModel extends AddCotisationEntity {
  const AddCotisationModel({
    required super.id,
    required super.amount,
    required super.year,
  });

  Map<String, dynamic> toJson() {
    return {'member_id': id, 'amount': amount, 'year': year};
  }
}
