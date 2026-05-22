import 'package:dartz/dartz.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/data/models/auth_register_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/domain/entities/info_entity.dart';

abstract class AuthRegisterRepository {
  Future<Either<Failure, InfoEntity>> createAccount({
    required AuthRegisterModel model,
  });
}
