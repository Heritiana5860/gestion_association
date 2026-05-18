import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/domain/entities/cotisation_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/domain/repositories/cotisation_repository.dart';

class CotisationUsecase {
  final CotisationRepository repository;

  const CotisationUsecase({required this.repository});

  Future<List<CotisationEntity>> call() {
    return repository.fetchCotisation();
  }
}
