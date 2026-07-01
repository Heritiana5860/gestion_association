import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/keys/token_key.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;
  final FlutterSecureStorage storage;

  late final Dio _refreshDio = Dio(dio.options);

  AuthInterceptor({required this.dio, required this.storage});

  // Injecter le token dans chaque requête
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await storage.read(key: TokenKey.tokenAccess);
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  // Intercepter les 401 et rafraîchir
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      try {
        final newToken = await _refreshToken();
        // Rejouer la requête originale avec le nouveau token
        final opts = err.requestOptions;
        opts.headers['Authorization'] = 'Bearer $newToken';
        final response = await dio.fetch(opts);
        return handler.resolve(response);
      } catch (e) {
        // Refresh échoué → déconnecter l'utilisateur
        await _logout();
        return handler.next(err);
      }
    }
    handler.next(err);
  }

  Future<String> _refreshToken() async {
    final refreshToken = await storage.read(key: TokenKey.refresh);
    if (refreshToken == null) throw Exception('No refresh token');

    final response = await _refreshDio.post(
      'token/refresh/',
      data: {'refresh': refreshToken},
    );

    final newAccessToken = response.data[TokenKey.tokenAccess];
    await storage.write(key: TokenKey.tokenAccess, value: newAccessToken);
    return newAccessToken;
  }

  Future<void> _logout() async {
    await storage.deleteAll();
  }
}
