import 'package:dartz/dartz.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/domain/entities/login_params.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/domain/entities/auth_session_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/domain/repositories/auth_login_repository.dart';

class AuthLoginUseCase {
  final AuthLoginRepository repository;

  const AuthLoginUseCase({required this.repository});

  Future<Either<Failure, AuthSessionEntity>> call(LoginParams params) {
    return repository.login(params);
  }
}
