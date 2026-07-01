import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/dio_exception_mapper.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/data/datasources/auth_register_datasource.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/data/models/auth_register_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/domain/entities/auth_register_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/domain/entities/auth_session_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/domain/repositories/auth_register_repository.dart';

class AuthRegisterRepositoryImpl implements AuthRegisterRepository {
  final AuthRegisterDatasource datasource;
  final AuthLocalDataSource local;

  const AuthRegisterRepositoryImpl({
    required this.datasource,
    required this.local,
  });

  @override
  Future<Either<Failure, AuthSessionEntity>> register(
    AuthRegisterEntity entity,
  ) async {
    try {
      final model = AuthRegisterModel(
        fullName: entity.fullName,
        username: entity.username,
        password: entity.password,
      );

      final session = await datasource.register(model);
      await local.saveToken(session);

      return Right(session);
    } on DioException catch (e) {
      return Left(mapDioExceptionToFailure(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
