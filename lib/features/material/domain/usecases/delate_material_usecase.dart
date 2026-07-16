import 'package:dartz/dartz.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/material/domain/repositories/material_repository.dart';

class DelateMaterialUsecase {
  final MaterialRepository repository;

  const DelateMaterialUsecase({required this.repository});

  Future<Either<Failure, void>> callDelete(int id) {
    return repository.deleteMaterial(id);
  }
}
