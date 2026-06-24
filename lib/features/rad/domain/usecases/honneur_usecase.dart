import 'package:dartz/dartz.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/data/models/honneur_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/entities/honneur_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/repositories/honneur_repository.dart';

class HonneurUsecase {
  final HonneurRepository repository;

  const HonneurUsecase({required this.repository});

  Future<Either<Failure, void>> call({required HonneurModel model}) {
    return repository.newHonneur(model: model);
  }

  Future<Either<Failure, List<HonneurEntity>>> callFetchHonneur() {
    return repository.fetchHonneur();
  }
}
