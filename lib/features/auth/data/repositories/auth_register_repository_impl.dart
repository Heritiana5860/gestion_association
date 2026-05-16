import 'package:login_with_unite_test_and_clean_architecture/features/auth/data/datasources/auth_register_datasource.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/data/models/auth_register_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/domain/repositories/auth_register_repository.dart';

class AuthRegisterRepositoryImpl implements AuthRegisterRepository {
  final AuthRegisterDatasource datasource;

  const AuthRegisterRepositoryImpl({required this.datasource});

  @override
  Future<void> createAccount({required AuthRegisterModel model}) {
    return datasource.register(model: model);
  }
}
