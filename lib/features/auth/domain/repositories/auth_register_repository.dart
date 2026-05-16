import 'package:login_with_unite_test_and_clean_architecture/features/auth/data/models/auth_register_model.dart';

abstract class AuthRegisterRepository {
  Future<void> createAccount({required AuthRegisterModel model});
}
