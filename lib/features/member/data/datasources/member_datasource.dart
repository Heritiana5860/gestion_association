import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/data/models/member_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/domain/entities/member_entity.dart';

class MemberDatasource {
  final Dio dio;

  const MemberDatasource({required this.dio});

  Future<List<MemberEntity>> fetchMembers({Map<String, dynamic>? params}) async {
    final baseUrl = dotenv.env['url'] ?? "";
    final response = await dio.get(
      "${baseUrl}member/",
      queryParameters: params,
    );

    final List<dynamic> data = response.data;

    if (data.isEmpty) {
      return [];
    }

    return data.map((e) => MemberModel.fromJson(e)).toList();
  }

  Future<void> add({required MemberModel model}) async {
    final baseUrl = dotenv.env['url'] ?? "";

    try {
      await dio.post(
        "${baseUrl}member/",
        data: model.toJson(),
        options: Options(headers: {"Content-Type": "application/json"}),
      );
    } on DioException catch (e) {
      if (e.response != null) {
        debugPrint("Données d'erreur du serveur: ${e.response?.data}");
        debugPrint("Statut d'erreur: ${e.response?.statusCode}");
      } else {
        debugPrint("Erreur de configuration ou de connexion: ${e.message}");
      }
    }
  }
}
