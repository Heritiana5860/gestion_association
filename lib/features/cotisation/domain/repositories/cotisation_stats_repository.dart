import 'package:dartz/dartz.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/domain/entities/cotisation_stats_entity.dart';

abstract class CotisationStatsRepository {
  Future<Either<Failure, CotisationStatsEntity>> cotisationStats({
    required String year,
  });
}
