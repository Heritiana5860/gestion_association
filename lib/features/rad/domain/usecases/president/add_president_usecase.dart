import 'package:dartz/dartz.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/entities/president_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/repositories/president_repository.dart';

class AddPresidentUsecase {
  final PresidentRepository repository;

  const AddPresidentUsecase({required this.repository});

  Future<Either<Failure, void>> call(PresidentEntity entity) {
    return repository.addPresident(entity);
  }
}
