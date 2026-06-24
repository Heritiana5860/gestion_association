import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/keys/url_key.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/network/autorisation_token.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/data/models/honneur_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/entities/honneur_entity.dart';

class HonneurDatasource {
  final Dio dio;

  const HonneurDatasource({required this.dio});

  Future<void> addHonneur({required HonneurModel model}) async {
    final url = dotenv.env[UrlKey.urlKey] ?? '';

    await dio.post(
      "${url}honneur/",
      data: model.toJson(),
      options: Options(headers: await AutorisationToken.headers()),
    );
  }

  Future<List<HonneurEntity>> getHonneur() async {
    final url = dotenv.env[UrlKey.urlKey] ?? '';

    final response = await dio.get("${url}honneur/");

    final List<dynamic> data = response.data;

    return data.map((e) => HonneurModel.fromJson(e)).toList();
  }
}
