import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/data/datasources/cotisation_stats_datasource.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/domain/entities/cotisation_stats_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/domain/repositories/cotisation_stats_repository.dart';

class CotisationStatsRepositoryImpl implements CotisationStatsRepository {
  final CotisationStatsDatasource datasource;

  const CotisationStatsRepositoryImpl({required this.datasource});

  @override
  Future<CotisationStatsEntity> cotisationStats() {
    return datasource.fetchCotisationStats();
  }
}
