import 'package:dartz/dartz.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/domain/entities/add_cotisation_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/domain/entities/cotisation_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/domain/repositories/cotisation_repository.dart';

class CotisationUsecase {
  final CotisationRepository repository;

  const CotisationUsecase({required this.repository});

  Future<Either<Failure, List<CotisationEntity>>> call({
    String? search,
    required String year,
  }) {
    return repository.cotisations(search: search, year: year);
  }

  Future<Either<Failure, void>> addCotisationCall({
    required AddCotisationEntity entity,
  }) {
    return repository.addCotisation(entity);
  }
}
