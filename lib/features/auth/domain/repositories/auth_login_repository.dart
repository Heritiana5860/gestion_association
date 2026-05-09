import 'package:login_with_unite_test_and_clean_architecture/features/auth/data/models/auth_model.dart';

abstract class AuthLoginRepository {
  Future<void> login({required AuthModel model});
}
