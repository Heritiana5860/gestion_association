import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/network_error.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/server_error.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/validation_error.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/data/datasources/cotisation_stats_datasource.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/domain/entities/cotisation_stats_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/domain/repositories/cotisation_stats_repository.dart';

class CotisationStatsRepositoryImpl implements CotisationStatsRepository {
  final CotisationStatsDatasource datasource;

  const CotisationStatsRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, CotisationStatsEntity>> cotisationStats() async {
    try {
      final response = await datasource.fetchCotisationStats();
      return Right(response);
    } on SocketException {
      return Left(NetworkError());
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        return Left(ValidationError(e.response?.data));
      }
      return Left(ServerError());
    } on Exception {
      return Left(ServerError());
    }
  }
}
