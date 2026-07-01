import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/dio_exception_mapper.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/data/datasources/cotisation_stats_datasource.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/domain/entities/cotisation_stats_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/domain/repositories/cotisation_stats_repository.dart';

class CotisationStatsRepositoryImpl implements CotisationStatsRepository {
  final CotisationStatsDatasource datasource;

  const CotisationStatsRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, CotisationStatsEntity>> cotisationStats({
    required String year,
  }) async {
    try {
      final response = await datasource.fetchCotisationStats(year: year);
      return Right(response);
    } on DioException catch (e) {
      return Left(mapDioExceptionToFailure(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
