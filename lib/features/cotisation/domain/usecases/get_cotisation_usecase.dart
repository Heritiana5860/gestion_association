import 'package:dartz/dartz.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/domain/entities/cotisation_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/domain/repositories/cotisation_repository.dart';

class GetCotisationUsecase {
  final CotisationRepository repository;

  const GetCotisationUsecase({required this.repository});

  Future<Either<Failure, List<CotisationEntity>>> call({
    String? search,
    required String year,
  }) {
    return repository.cotisations(search: search, year: year);
  }
}
