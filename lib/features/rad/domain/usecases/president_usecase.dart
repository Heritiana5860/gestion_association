import 'package:dartz/dartz.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/data/models/president_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/entities/president_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/repositories/president_repository.dart';

class PresidentUsecase {
  final PresidentRepository repository;

  const PresidentUsecase({required this.repository});

  Future<Either<Failure, void>> call({required PresidentModel model}) {
    return repository.addPresident(model: model);
  }

  Future<Either<Failure, List<PresidentEntity>>> fetchPresidentList() {
    return repository.getPresidents();
  }

  Future<Either<Failure, void>> callPresidentUpdate({
    required int id,
    required PresidentModel model,
  }) {
    return repository.updatePresident(id: id, model: model);
  }
}
