import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/keys/url_key.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/network/autorisation_token.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/data/models/cadre_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/entities/cadre_entity.dart';

class CadreDatasource {
  final Dio dio;

  const CadreDatasource({required this.dio});

  Future<void> addCadre({required CadreModel model}) async {
    final url = dotenv.env[UrlKey.urlKey] ?? '';

    await dio.post(
      "${url}cadre/",
      data: model.toJson(),
      options: Options(headers: await AutorisationToken.headers()),
    );
  }

  Future<List<CadreEntity>> getCadre() async {
    final url = dotenv.env[UrlKey.urlKey] ?? '';

    final response = await dio.get("${url}cadre/");
    final List<dynamic> data = response.data;

    return data.map((e) => CadreModel.fromJson(e)).toList();
  }

  Future<void> updateCadreData({
    required int id,
    required CadreModel model,
  }) async {
    final url = dotenv.env[UrlKey.urlKey] ?? '';

    await dio.put(
      "${url}cadre/$id/",
      data: model.toJson(),
      options: Options(headers: await AutorisationToken.headers()),
    );
  }
}
