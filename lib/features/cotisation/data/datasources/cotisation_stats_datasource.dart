import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/keys/url_key.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/network/autorisation_token.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/data/models/cotisation_stats_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/domain/entities/cotisation_stats_entity.dart';

class CotisationStatsDatasource {
  final Dio dio;

  const CotisationStatsDatasource({required this.dio});

  Future<CotisationStatsEntity> fetchCotisationStats({required String year}) async {
    final url = dotenv.env[UrlKey.urlKey] ?? "";

    final Map<String, dynamic> queryParams = {};
    queryParams['year'] = year;

    try {
      final response = await dio.get(
        "${url}cotisation/statistics/",
        queryParameters: queryParams,
        options: Options(headers: await AutorisationToken.headers()),
      );

      return CotisationStatsModel.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint("Erreur: $e");
      rethrow;
    }
  }
}
