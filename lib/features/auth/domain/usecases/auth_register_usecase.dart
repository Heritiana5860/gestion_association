import 'package:login_with_unite_test_and_clean_architecture/features/auth/data/models/auth_register_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/domain/repositories/auth_register_repository.dart';

class AuthRegisterUsecase {
  final AuthRegisterRepository repository;

  const AuthRegisterUsecase({required this.repository});

  Future<void> newUser({required AuthRegisterModel model}) {
    return repository.createAccount(model: model);
  }
}
