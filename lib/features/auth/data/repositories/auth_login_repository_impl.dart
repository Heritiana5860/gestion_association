import 'package:login_with_unite_test_and_clean_architecture/features/auth/data/datasources/auth_login_datasource.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/data/models/auth_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/domain/entities/info_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/domain/repositories/auth_login_repository.dart';

class AuthLoginRepositoryImpl implements AuthLoginRepository {
  final AuthLoginDatasource datasource;

  const AuthLoginRepositoryImpl({required this.datasource});

  @override
  Future<InfoEntity> login({required AuthModel model}) {
    return datasource.authSubmit(model: model);
  }
}
