import 'package:dartz/dartz.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/obligation/data/models/obligation_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/obligation/domain/entities/obligation_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/obligation/domain/repositories/add_obligation_repository.dart';

class AddObligationUsecase {
  final AddObligationRepository repository;

  const AddObligationUsecase({required this.repository});

  Future<Either<Failure, void>> callAdd({required ObligationModel model}) {
    return repository.addObligation(model: model);
  }

  Future<Either<Failure, List<ObligationEntity>>> call() {
    return repository.fetchObligation();
  }
}
