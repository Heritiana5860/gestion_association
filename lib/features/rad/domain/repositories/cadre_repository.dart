import 'package:dartz/dartz.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/entities/cadre_entity.dart';

abstract class CadreRepository {
  Future<Either<Failure, void>> addCadre(CadreEntity entity);
  Future<Either<Failure, List<CadreEntity>>> cadres();
  Future<Either<Failure, void>> updateCadre({
    required int id,
    required CadreEntity entity,
  });
}
