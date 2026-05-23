import 'package:dartz/dartz.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/obligation/data/models/obligation_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/obligation/domain/entities/obligation_entity.dart';

abstract class AddObligationRepository {
  Future<Either<Failure, void>> addObligation({required ObligationModel model});
  Future<Either<Failure, List<ObligationEntity>>> fetchObligation();
}
