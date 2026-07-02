import 'package:dartz/dartz.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/domain/entities/add_cotisation_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/domain/entities/cotisation_entity.dart';

abstract class CotisationRepository {
  Future<Either<Failure, List<CotisationEntity>>> cotisations({
    String? search,
    required String year,
  });
  Future<Either<Failure, void>> addCotisation(AddCotisationEntity entity);
}
