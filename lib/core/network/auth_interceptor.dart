import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/keys/token_key.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/keys/url_key.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;
  final FlutterSecureStorage storage;

  AuthInterceptor({required this.dio, required this.storage});

  // Injecter le token dans chaque requête
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await storage.read(key: TokenKey.token);
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

    final url = dotenv.env[UrlKey.urlKey];
    // Utiliser un Dio séparé pour éviter une boucle infinie
    final refreshDio = Dio();
    final response = await refreshDio.post(
      '${url}token/refresh/',
      data: {'refresh': refreshToken},
    );

    final newAccessToken = response.data[TokenKey.token];
    await storage.write(key: TokenKey.token, value: newAccessToken);
    return newAccessToken;
  }

  Future<void> _logout() async {
    await storage.deleteAll();
    // if (context.mounted) {
    //   context.goNamed(RouteKeys.loginName);
    // }
  }
}
