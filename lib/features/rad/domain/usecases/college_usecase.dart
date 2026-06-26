import 'package:dartz/dartz.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/data/models/college_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/repositories/college_repository.dart';

class CollegeUsecase {
  final CollegeRepository repository;

  const CollegeUsecase({required this.repository});

  Future<Either<Failure, void>> callAddCollege({required CollegeModel model}) {
    return repository.addCollege(model: model);
  }
}
