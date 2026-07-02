import 'package:dartz/dartz.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/entities/president_entity.dart';

abstract class PresidentRepository {
  Future<Either<Failure, void>> addPresident(PresidentEntity entity);
  Future<Either<Failure, void>> updatePresident({
    required int id,
    required PresidentEntity entity,
  });
  Future<Either<Failure, List<PresidentEntity>>> presidents();
}
