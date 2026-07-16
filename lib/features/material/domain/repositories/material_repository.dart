import 'package:dartz/dartz.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/material/domain/entities/material_entity.dart';

abstract class MaterialRepository {
  Future<Either<Failure, void>> addMaterial(MaterialEntity entity);
  Future<Either<Failure, List<MaterialEntity>>> materials();
  Future<Either<Failure, void>> updateMaterial({required int id, required MaterialEntity entity});
}
