import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/domain/entities/cotisation_stats_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/domain/repositories/cotisation_stats_repository.dart';

class CotisationStatsUsecase {
  final CotisationStatsRepository repository;

  const CotisationStatsUsecase({required this.repository});

  Future<CotisationStatsEntity> call() {
    return repository.cotisationStats();
  }
}
