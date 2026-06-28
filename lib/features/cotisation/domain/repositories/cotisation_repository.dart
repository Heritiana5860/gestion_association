import 'package:dartz/dartz.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/data/models/add_cotisation_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/domain/entities/cotisation_entity.dart';

abstract class CotisationRepository {
  Future<Either<Failure, List<CotisationEntity>>> fetchCotisation({
    String? search,
    required String year,
  });
  Future<Either<Failure, void>> addCotisation({
    required AddCotisationModel model,
  });
}
