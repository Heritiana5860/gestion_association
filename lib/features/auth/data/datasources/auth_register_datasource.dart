import 'package:dio/dio.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/network/api_endpoints.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/data/models/auth_register_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/data/models/auth_session_model.dart';

abstract class AuthRegisterDatasource {
  Future<AuthSessionModel> register(AuthRegisterModel model);
}

class AuthRegisterDatasourceImpl implements AuthRegisterDatasource {
  final Dio dio;

  const AuthRegisterDatasourceImpl({required this.dio});

  @override
  Future<AuthSessionModel> register(AuthRegisterModel model) async {
    final response = await dio.post(
      ApiEndpoints.register,
      data: model.toJson(),
    );

    return AuthSessionModel.fromJson(response.data);
  }
}
