import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/network/autorisation_token.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/data/models/member_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/domain/entities/member_entity.dart';

class MemberDatasource {
  final Dio dio;

  const MemberDatasource({required this.dio});

  Future<List<MemberEntity>> fetchMembers({
    Map<String, dynamic>? params,
  }) async {
    final baseUrl = dotenv.env['url'] ?? "";
    final response = await dio.get(
      "${baseUrl}member/",
      queryParameters: params,
      // options: Options(headers: await AutorisationToken.headers()),
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
        options: Options(headers: await AutorisationToken.headers()),
      );
    } on DioException catch (e) {
      debugPrint("Erreur add: ${e.response?.data} | ${e.message}");
      rethrow;
    }
  }

  Future<void> update({required int id, required MemberModel model}) async {
    final baseUrl = dotenv.env['url'] ?? "";

    try {
      await dio.put(
        "${baseUrl}member/$id/",
        data: model.toJson(),
        options: Options(headers: await AutorisationToken.headers()),
      );
    } on DioException catch (e) {
      debugPrint("Erreur add: ${e.response?.data} | ${e.message}");
      rethrow;
    }
  }

  Future<MemberEntity> detail({required int id}) async {
    final baseUrl = dotenv.env['url'] ?? "";

    final response = await dio.get(
      "${baseUrl}member/$id/",
      options: Options(headers: await AutorisationToken.headers()),
    );

    final dynamic data = response.data;

    return MemberModel.fromJson(data);
  }

  Future<void> delete({required int id}) async {
    final baseUrl = dotenv.env['url'] ?? "";
    await dio.delete(
      "${baseUrl}member/$id/",
      options: Options(headers: await AutorisationToken.headers()),
    );
  }
}
