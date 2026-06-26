import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/network_error.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/server_error.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/validation_error.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/data/datasources/college_datasource.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/data/models/college_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/repositories/college_repository.dart';

class CollegeRepositoryImpl implements CollegeRepository {
  final CollegeDatasource datasource;

  const CollegeRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, void>> addCollege({
    required CollegeModel model,
  }) async {
    try {
      final res = await datasource.addCollege(model: model);
      return Right(res);
    } on SocketException {
      return Left(NetworkError());
    } on DioException catch (e) {
      return Left(ValidationError(e.response!.data));
    } on Exception {
      return Left(ServerError());
    }
  }
}
