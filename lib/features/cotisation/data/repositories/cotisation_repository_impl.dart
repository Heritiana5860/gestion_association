import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/dio_exception_mapper.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/data/datasources/cotisation_datasource.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/data/models/add_cotisation_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/domain/entities/cotisation_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/domain/repositories/cotisation_repository.dart';

class CotisationRepositoryImpl implements CotisationRepository {
  final CotisationDatasource datasource;

  const CotisationRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, List<CotisationEntity>>> fetchCotisation({
    String? search,
    required String year,
  }) async {
    try {
      final response = await datasource.cotisation(search: search, year: year);
      return Right(response);
    } on DioException catch (e) {
      return Left(mapDioExceptionToFailure(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addCotisation({
    required AddCotisationModel model,
  }) async {
    try {
      final response = await datasource.addCotisation(model: model);
      return Right(response);
    } on DioException catch (e) {
      return Left(mapDioExceptionToFailure(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
