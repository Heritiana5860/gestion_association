import 'package:dartz/dartz.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/domain/entities/cotisation_stats_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/domain/repositories/cotisation_stats_repository.dart';

class CotisationStatsUsecase {
  final CotisationStatsRepository repository;

  const CotisationStatsUsecase({required this.repository});

  Future<Either<Failure, CotisationStatsEntity>> call({required String year}) {
    return repository.cotisationStats(year: year);
  }
}
