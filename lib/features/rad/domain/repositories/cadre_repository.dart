import 'package:dartz/dartz.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/data/models/cadre_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/entities/cadre_entity.dart';

abstract class CadreRepository {
  Future<Either<Failure, void>> newCadre({required CadreModel model});
  Future<Either<Failure, List<CadreEntity>>> fetchCadre();
  Future<Either<Failure, void>> updateCadre({
    required int id,
    required CadreModel model,
  });
}
