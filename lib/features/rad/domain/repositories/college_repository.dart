import 'package:dartz/dartz.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/entities/college_entity.dart';

abstract class CollegeRepository {
  Future<Either<Failure, List<CollegeEntity>>> colleges(String year);
  Future<Either<Failure, void>> addCollege(CollegeEntity entity);
  Future<Either<Failure, void>> updateCollege({
    required int id,
    required CollegeEntity entity,
  });
}
