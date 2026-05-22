import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/network_error.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/server_error.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/validation_error.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/data/datasources/member_stats_datasource.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/domain/entities/member_stats_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/domain/repositories/member_stats_repository.dart';

class MemberStatsRepositoryImpl implements MemberStatsRepository {
  final MemberStatsDatasource datasource;

  const MemberStatsRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, MemberStatsEntity>> memberStats() async {
    try {
      final response = await datasource.stats();
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
