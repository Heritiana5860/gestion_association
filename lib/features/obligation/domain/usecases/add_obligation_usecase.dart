import 'package:dartz/dartz.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/obligation/domain/entities/obligation_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/obligation/domain/repositories/add_obligation_repository.dart';

class AddObligationUsecase {
  final AddObligationRepository repository;

  const AddObligationUsecase({required this.repository});

  Future<Either<Failure, void>> callAdd(ObligationEntity entity) {
    return repository.addObligation(entity);
  }

  Future<Either<Failure, List<ObligationEntity>>> call() {
    return repository.obligations();
  }
}
