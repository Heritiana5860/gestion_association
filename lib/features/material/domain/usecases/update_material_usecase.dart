import 'package:dartz/dartz.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/material/domain/entities/material_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/material/domain/repositories/material_repository.dart';

class UpdateMaterialUsecase {
  final MaterialRepository repository;

  const UpdateMaterialUsecase({required this.repository});

  Future<Either<Failure, void>> callUpdate({
    required int id,
    required MaterialEntity entity,
  }) {
    return repository.updateMaterial(id: id, entity: entity);
  }
}
