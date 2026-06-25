import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/network_error.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/server_error.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/validation_error.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/data/datasources/cadre_datasource.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/data/models/cadre_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/entities/cadre_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/repositories/cadre_repository.dart';

class CadreRepositoryImpl implements CadreRepository {
  final CadreDatasource datasource;

  const CadreRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, void>> newCadre({required CadreModel model}) async {
    try {
      final res = await datasource.addCadre(model: model);
      return Right(res);
    } on SocketException {
      return Left(NetworkError());
    } on Exception catch (e) {
      return Left(ValidationError(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CadreEntity>>> fetchCadre() async {
    try {
      final res = await datasource.getCadre();
      return Right(res);
    } on SocketException {
      return Left(NetworkError());
    } on DioException catch (e) {
      return Left(ValidationError(e.toString()));
    } on Exception {
      return Left(ServerError());
    }
  }
}
