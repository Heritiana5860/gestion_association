import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/keys/url_key.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/network/autorisation_token.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/data/models/president_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/entities/president_entity.dart';

class PresidentDatasource {
  final Dio dio;

  const PresidentDatasource({required this.dio});

  Future<void> president({required PresidentModel model}) async {
    final url = dotenv.env[UrlKey.urlKey] ?? "";

    await dio.post(
      "${url}president/",
      data: model.toJson(),
      options: Options(headers: await AutorisationToken.headers()),
    );
  }

  Future<List<PresidentEntity>> fetchPresident() async {
    final url = dotenv.env[UrlKey.urlKey] ?? "";

    final response = await dio.get("${url}president/");

    final List<dynamic> data = response.data;

    return data.map((e) => PresidentModel.fromJson(e)).toList();
  }

  Future<void> presidentUpdate({
    required int id,
    required PresidentModel model,
  }) async {
    final url = dotenv.env[UrlKey.urlKey] ?? "";

    await dio.put(
      "${url}president/$id/",
      data: model.toJson(),
      options: Options(headers: await AutorisationToken.headers()),
    );
  }
}
