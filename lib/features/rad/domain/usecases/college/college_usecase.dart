import 'package:dartz/dartz.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/entities/college_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/repositories/college_repository.dart';

class CollegeUsecase {
  final CollegeRepository repository;

  const CollegeUsecase({required this.repository});

  Future<Either<Failure, List<CollegeEntity>>> call(String year) {
    return repository.colleges(year);
  }
}
