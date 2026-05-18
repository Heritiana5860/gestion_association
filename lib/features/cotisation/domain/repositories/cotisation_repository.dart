import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/domain/entities/cotisation_entity.dart';

abstract class CotisationRepository {
  Future<List<CotisationEntity>> fetchCotisation();
}
