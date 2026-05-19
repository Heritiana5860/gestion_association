import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/keys/info_key.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/keys/token_key.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/keys/url_key.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/auth/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/data/models/auth_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/domain/entities/info_entity.dart';

class AuthLoginDatasource {
  final FlutterSecureStorage storage;
  final Dio dio;

  const AuthLoginDatasource({required this.storage, required this.dio});

  Future<InfoEntity> authSubmit({required AuthModel model}) async {
    final url = dotenv.env[UrlKey.urlKey];

    try {
      final response = await dio.post("${url}token/", data: model.toJson());

      await Future.wait([
        storage.write(
          key: TokenKey.token,
          value: response.data[TokenKey.token],
        ),
        storage.write(
          key: TokenKey.refresh,
          value: response.data[TokenKey.refresh],
        ),
      ]);

      return InfoEntity(
        fullName: response.data[InfoKey.fName],
        username: response.data[InfoKey.username],
      );
    } on DioException catch (e) {
      // Interception fine des codes HTTP
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw const NetworkFailure();
      }

      if (e.response?.statusCode == 401 || e.response?.statusCode == 400) {
        throw const InvalidCredentialsFailure();
      }

      if (e.response?.statusCode != null && e.response!.statusCode! >= 500) {
        throw const ServerFailure();
      }

      throw UnknownAuthFailure(
        e.message ?? "Une erreur inconnue est survenue.",
      );
    }
  }
}
