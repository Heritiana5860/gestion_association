import 'package:login_with_unite_test_and_clean_architecture/features/auth/data/models/auth_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/domain/entities/info_entity.dart';

abstract class AuthLoginRepository {
  Future<InfoEntity> login({required AuthModel model});
}
