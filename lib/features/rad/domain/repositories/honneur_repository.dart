import 'package:dartz/dartz.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/data/models/honneur_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/entities/honneur_entity.dart';

abstract class HonneurRepository {
  Future<Either<Failure, void>> newHonneur({required HonneurModel model});
  Future<Either<Failure, List<HonneurEntity>>> fetchHonneur();
}
