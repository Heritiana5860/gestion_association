import 'package:dartz/dartz.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/obligation/domain/entities/obligation_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/obligation/domain/repositories/add_obligation_repository.dart';

class ObligationUsercase {
  final AddObligationRepository repository;

  const ObligationUsercase({required this.repository});

  Future<Either<Failure, List<ObligationEntity>>> call() {
    return repository.obligations();
  }
}
