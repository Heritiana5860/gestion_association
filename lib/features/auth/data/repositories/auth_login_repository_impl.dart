import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/auth/login_error.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/network_error.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/server_error.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/validation_error.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/data/datasources/auth_login_datasource.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/data/models/auth_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/domain/entities/info_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/domain/repositories/auth_login_repository.dart';

class AuthLoginRepositoryImpl implements AuthLoginRepository {
  final AuthLoginDatasource datasource;

  const AuthLoginRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, InfoEntity>> login({required AuthModel model}) async {
    try {
      final response = await datasource.authSubmit(model: model);
      return Right(response);
    } on SocketException {
      return Left(NetworkError());
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        return Left(ValidationError(e.response?.data));
      } else if (e.response?.statusCode == 401) {
        return Left(InvalidCredentialsFailure());
      }

      return Left(ServerError());
    } on Exception {
      return Left(ServerError());
    }
  }
}
