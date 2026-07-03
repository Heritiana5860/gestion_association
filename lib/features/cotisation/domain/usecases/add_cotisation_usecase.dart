import 'package:dartz/dartz.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/domain/entities/add_cotisation_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/domain/repositories/cotisation_repository.dart';

class AddCotisationUsecase {
  final CotisationRepository repository;

  const AddCotisationUsecase({required this.repository});

  Future<Either<Failure, void>> addCotisationCall(AddCotisationEntity entity) {
    return repository.addCotisation(entity);
  }
}
