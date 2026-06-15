import 'package:dartz/dartz.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/data/models/president_model.dart';

abstract class PresidentRepository {
  Future<Either<Failure, void>> addPresident({required PresidentModel model});
  // Future<Either<Failure, void>> updatePresident(String id, String name, String description);
  // Future<Either<Failure, void>> deletePresident(String id);
  // Future<Either<Failure, List<President>>> getPresidents();
}
