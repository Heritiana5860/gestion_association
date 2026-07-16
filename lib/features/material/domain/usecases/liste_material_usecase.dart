import 'package:dartz/dartz.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/material/domain/entities/material_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/material/domain/repositories/material_repository.dart';

class ListeMaterialUsecase {
  final MaterialRepository repository;

  const ListeMaterialUsecase({required this.repository});

  Future<Either<Failure, List<MaterialEntity>>> call() {
    return repository.materials();
  }
}
