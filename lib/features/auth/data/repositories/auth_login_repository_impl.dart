import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/dio_exception_mapper.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/data/models/auth_login_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/domain/entities/login_params.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/domain/entities/auth_session_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/domain/repositories/auth_login_repository.dart';

class AuthLoginRepositoryImpl implements AuthLoginRepository {
  final AuthRemoteDataSource remote;
  final AuthLocalDataSource local;

  const AuthLoginRepositoryImpl({required this.remote, required this.local});

  @override
  Future<Either<Failure, AuthSessionEntity>> login(LoginParams params) async {
    try {
      final model = AuthLoginModel(
        username: params.username,
        password: params.password,
      );

      final session = await remote.login(model);
      await local.saveToken(session);

      return Right(session);
    } on DioException catch (e) {
      return Left(mapDioExceptionToFailure(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
