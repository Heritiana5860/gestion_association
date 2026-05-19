import 'package:login_with_unite_test_and_clean_architecture/features/auth/data/models/auth_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/domain/entities/info_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/domain/repositories/auth_login_repository.dart';

class AuthLoginUsecase {
  final AuthLoginRepository repository;

  const AuthLoginUsecase({required this.repository});

  Future<InfoEntity> call({required AuthModel model}) {
    return repository.login(model: model);
  }
}
