import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/network_error.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/validation_error.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/data/datasources/honneur_datasource.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/data/models/honneur_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/entities/honneur_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/repositories/honneur_repository.dart';

class HonneurRepositoryImpl implements HonneurRepository {
  final HonneurDatasource datasource;

  const HonneurRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, void>> newHonneur({
    required HonneurModel model,
  }) async {
    try {
      final res = await datasource.addHonneur(model: model);
      return Right(res);
    } on SocketException {
      return Left(NetworkError());
    } on Exception catch (e) {
      return Left(ValidationError(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<HonneurEntity>>> fetchHonneur() async {
    try {
      final res = await datasource.getHonneur();
      return Right(res);
    } on SocketException {
      return Left(NetworkError());
    } on Exception catch (e) {
      return Left(ValidationError(e.toString()));
    }
  }
}
