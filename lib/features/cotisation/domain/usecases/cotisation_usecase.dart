import 'package:dartz/dartz.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/data/models/add_cotisation_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/domain/entities/cotisation_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/domain/repositories/cotisation_repository.dart';

class CotisationUsecase {
  final CotisationRepository repository;

  const CotisationUsecase({required this.repository});

  Future<Either<Failure, List<CotisationEntity>>> call() {
    return repository.fetchCotisation();
  }

  Future<Either<Failure, void>> addCotisationCall({
    required AddCotisationModel model,
  }) {
    return repository.addCotisation(model: model);
  }
}
