import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/register/register_error.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/data/datasources/auth_register_datasource.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/data/models/auth_register_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/domain/entities/info_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/domain/repositories/auth_register_repository.dart';

class AuthRegisterRepositoryImpl implements AuthRegisterRepository {
  final AuthRegisterDatasource datasource;

  const AuthRegisterRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, InfoEntity>> createAccount({
    required AuthRegisterModel model,
  }) async {
    try {
      final response = await datasource.register(model: model);
      return Right(response);
    } on SocketException {
      return Left(RegisterError(message: "Erreur de connexion internet."));
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        return Left(ValidationError(e.response?.data));
      }

      return Left(const ServerError());
    } on Exception {
      return Left(const ServerError());
    }
  }
}
