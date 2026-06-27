import 'package:dartz/dartz.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/data/models/college_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/entities/college_entity.dart';

abstract class CollegeRepository {
  Future<Either<Failure, List<CollegeEntity>>> fetchCollege();
  Future<Either<Failure, void>> addCollege({required CollegeModel model});
  Future<Either<Failure, void>> updateCollege({
    required int id,
    required CollegeModel model,
  });
}
