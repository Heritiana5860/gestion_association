import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/keys/url_key.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/network/autorisation_token.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/data/models/add_cotisation_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/data/models/cotisation_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/domain/entities/cotisation_entity.dart';

class CotisationDatasource {
  final Dio dio;

  const CotisationDatasource({required this.dio});

  Future<List<CotisationEntity>> cotisation() async {
    final url = dotenv.env[UrlKey.urlKey] ?? "";
    final response = await dio.get(
      "${url}cotisation/",
      options: Options(headers: await AutorisationToken.headers()),
    );

    debugPrint("cotisation: $response");

    final List<dynamic> data = response.data;

    return data.map((e) => CotisationModel.fromJson(e)).toList();
  }

  Future<void> addCotisation({required AddCotisationModel model}) async {
    final url = dotenv.env[UrlKey.urlKey] ?? "";
    await dio.post(
      "${url}cotisation/add/",
      data: model.toJson(),
      options: Options(headers: await AutorisationToken.headers()),
    );
  }
}
