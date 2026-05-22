import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/keys/info_key.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/keys/token_key.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/keys/url_key.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/data/models/auth_register_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/domain/entities/info_entity.dart';

class AuthRegisterDatasource {
  final Dio dio;
  final FlutterSecureStorage storage;

  const AuthRegisterDatasource({required this.dio, required this.storage});

  Future<InfoEntity> register({required AuthRegisterModel model}) async {
    final url = dotenv.env[UrlKey.urlKey] ?? '';

    final response = await dio.post("${url}register/", data: model.toJson());

    debugPrint("response: $response");

    await Future.wait([
      storage.write(key: TokenKey.token, value: response.data[TokenKey.token]),
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
