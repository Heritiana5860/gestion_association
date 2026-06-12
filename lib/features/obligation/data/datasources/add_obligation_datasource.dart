import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/keys/url_key.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/obligation/data/models/obligation_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/obligation/domain/entities/obligation_entity.dart';

class AddObligationDatasource {
  final Dio dio;

  const AddObligationDatasource({required this.dio});

  Future<void> createObligation({required ObligationModel model}) async {
    final url = dotenv.env[UrlKey.urlKey] ?? "";

    try {
      await dio.post(
        "${url}annuel/fix_statut_amount/",
        data: model.toJson(),
        // options: Options(headers: await AutorisationToken.headers()),
      );
    } on DioException catch (e) {
      debugPrint("Erreur: $e");
      rethrow;
    }
  }

  Future<List<ObligationEntity>> allObligations() async {
    final url = dotenv.env[UrlKey.urlKey] ?? "";

    try {
      final response = await dio.get(
        "${url}annuel/",
      );

      final List<dynamic> data = response.data;

      return data.map((d) => ObligationModel.fromJson(d)).toList();
    } on DioException catch (e) {
      debugPrint("Erreur: $e");
      rethrow;
    }
  }
}
