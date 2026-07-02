import 'package:dartz/dartz.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/entities/honneur_entity.dart';

abstract class HonneurRepository {
  Future<Either<Failure, void>> addHonneur(HonneurEntity entity);
  Future<Either<Failure, List<HonneurEntity>>> honneurs();
  Future<Either<Failure, void>> updateHonneur({
    required int id,
    required HonneurEntity entity,
  });
}
