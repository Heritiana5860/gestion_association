import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/network_error.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/server_error.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/data/datasources/president_datasource.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/data/models/president_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/entities/president_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/repositories/president_repository.dart';

class PresidentRepositoryImpl implements PresidentRepository {
  final PresidentDatasource datasource;

  const PresidentRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, void>> addPresident({
    required PresidentModel model,
  }) async {
    try {
      final res = await datasource.president(model: model);
      return Right(res);
    } on SocketException {
      return Left(NetworkError());
    } on DioException catch (e) {
      return Left(e.response?.data);
    } on Exception {
      return Left(ServerError());
    }
  }

  @override
  Future<Either<Failure, List<PresidentEntity>>> getPresidents() async {
    try {
      final res = await datasource.fetchPresident();
      return Right(res);
    } on SocketException {
      return Left(NetworkError());
    } on DioException catch (e) {
      return Left(e.response?.data);
    } on Exception {
      return Left(ServerError());
    }
  }

  @override
  Future<Either<Failure, void>> updatePresident({
    required int id,
    required PresidentModel model,
  }) async {
    try {
      final res = await datasource.presidentUpdate(id: id, model: model);
      return Right(res);
    } on SocketException {
      return Left(NetworkError());
    } on DioException catch (e) {
      return Left(e.response?.data);
    } on Exception {
      return Left(ServerError());
    }
  }
}
