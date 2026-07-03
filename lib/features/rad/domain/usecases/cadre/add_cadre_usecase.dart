import 'package:dartz/dartz.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/entities/cadre_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/repositories/cadre_repository.dart';

class AddCadreUsecase {
  final CadreRepository repository;

  const AddCadreUsecase({required this.repository});

  Future<Either<Failure, void>> call(CadreEntity entity) {
    return repository.addCadre(entity);
  }
}
