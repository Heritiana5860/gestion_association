import 'package:dio/dio.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/network/api_endpoints.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/data/models/auth_login_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/data/models/auth_session_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthSessionModel> login(AuthLoginModel model);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  const AuthRemoteDataSourceImpl({required this.dio});

  @override
  Future<AuthSessionModel> login(AuthLoginModel model) async {
    final response = await dio.post(ApiEndpoints.token, data: model.toJson());

    return AuthSessionModel.fromJson(response.data);
  }
}
