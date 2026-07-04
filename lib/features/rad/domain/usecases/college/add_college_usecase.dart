import 'package:dartz/dartz.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/entities/college_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/repositories/college_repository.dart';

class AddCollegeUsecase {
  final CollegeRepository repository;

  const AddCollegeUsecase({required this.repository});

  Future<Either<Failure, void>> callAddCollege(CollegeEntity entity) {
    return repository.addCollege(entity);
  }
}
