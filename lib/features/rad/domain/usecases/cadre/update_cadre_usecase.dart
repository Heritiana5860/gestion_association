import 'package:dartz/dartz.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/entities/cadre_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/repositories/cadre_repository.dart';

class UpdateCadreUsecase {
  final CadreRepository repository;

  const UpdateCadreUsecase({required this.repository});

  Future<Either<Failure, void>> callCadreUpdate({
    required int id,
    required CadreEntity entity,
  }) {
    return repository.updateCadre(id: id, entity: entity);
  }
}
