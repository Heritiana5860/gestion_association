import 'package:dartz/dartz.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/domain/entities/auth_register_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/domain/entities/auth_session_entity.dart';

abstract class AuthRegisterRepository {
  Future<Either<Failure, AuthSessionEntity>> register(
    AuthRegisterEntity entity,
  );
}
