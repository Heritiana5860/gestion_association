import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/keys/info_key.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/keys/token_key.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/network/api_endpoints.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/data/models/auth_register_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/domain/entities/info_entity.dart';

class AuthRegisterDatasource {
  final Dio dio;
  final FlutterSecureStorage storage;

  const AuthRegisterDatasource({required this.dio, required this.storage});

  Future<InfoEntity> register({required AuthRegisterModel model}) async {
    final response = await dio.post(
      ApiEndpoints.register,
      data: model.toJson(),
    );

    await Future.wait([
      storage.write(
        key: TokenKey.tokenAccess,
        value: response.data[TokenKey.tokenAccess],
      ),
      storage.write(
        key: TokenKey.refresh,
        value: response.data[TokenKey.refresh],
      ),
    ]);

    return InfoEntity(
      fullName: response.data[InfoKey.fullName],
      username: response.data[InfoKey.username],
    );
  }
}
