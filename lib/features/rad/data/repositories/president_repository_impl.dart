import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/network_error.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/validation_error.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/data/datasources/president_datasource.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/data/models/president_model.dart';
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
      return const Left(NetworkError());
    } on Exception catch (e) {
      return Left(ValidationError(e.toString()));
    }
  }
}
