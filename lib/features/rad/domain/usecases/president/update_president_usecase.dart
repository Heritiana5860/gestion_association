import 'package:dartz/dartz.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/entities/president_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/repositories/president_repository.dart';

class UpdatePresidentUsecase {
  final PresidentRepository repository;

  const UpdatePresidentUsecase({required this.repository});

  Future<Either<Failure, void>> callPresidentUpdate({
    required int id,
    required PresidentEntity entity,
  }) {
    return repository.updatePresident(id: id, entity: entity);
  }
}
