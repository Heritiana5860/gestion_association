import 'package:dartz/dartz.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/data/models/cadre_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/entities/cadre_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/repositories/cadre_repository.dart';

class CadreUsecase {
  final CadreRepository repository;

  const CadreUsecase({required this.repository});

  Future<Either<Failure, void>> call({required CadreModel model}) {
    return repository.newCadre(model: model);
  }

  Future<Either<Failure, List<CadreEntity>>> callCadre() {
    return repository.fetchCadre();
  }

  Future<Either<Failure, void>> callCadreUpdate({
    required int id,
    required CadreModel model,
  }) {
    return repository.updateCadre(id: id, model: model);
  }
}
