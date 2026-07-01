import 'package:dartz/dartz.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/domain/entities/login_params.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/domain/entities/auth_session_entity.dart';

abstract class AuthLoginRepository {
  Future<Either<Failure, AuthSessionEntity>> login(LoginParams params);
}
