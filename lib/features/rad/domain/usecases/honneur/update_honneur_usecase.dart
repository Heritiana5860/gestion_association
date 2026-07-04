import 'package:dartz/dartz.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/entities/honneur_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/repositories/honneur_repository.dart';

class UpdateHonneurUsecase {
  final HonneurRepository repository;

  const UpdateHonneurUsecase({required this.repository});

  Future<Either<Failure, void>> callUpdateHonneur({
    required int id,
    required HonneurEntity entity,
  }) {
    return repository.updateHonneur(id: id, entity: entity);
  }
}
