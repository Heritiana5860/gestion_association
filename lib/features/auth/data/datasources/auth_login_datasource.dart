import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/keys/info_key.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/keys/token_key.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/keys/url_key.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/data/models/auth_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/domain/entities/info_entity.dart';

class AuthLoginDatasource {
  final FlutterSecureStorage storage;
  final Dio dio;

  const AuthLoginDatasource({required this.storage, required this.dio});

  Future<InfoEntity> authSubmit({required AuthModel model}) async {
    final url = dotenv.env[UrlKey.urlKey];

    final response = await dio.post("${url}token/", data: model.toJson());

    await Future.wait([
      storage.write(key: TokenKey.token, value: response.data[TokenKey.token]),
      storage.write(
        key: TokenKey.refresh,
        value: response.data[TokenKey.refresh],
      ),
    ]);

    return InfoEntity(
      fullName: response.data[InfoKey.fName],
      username: response.data[InfoKey.username],
    );
  }
}
