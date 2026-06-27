import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/keys/url_key.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/network/autorisation_token.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/data/models/college_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/entities/college_entity.dart';

class CollegeDatasource {
  final Dio dio;

  const CollegeDatasource({required this.dio});

  Future<void> addCollege({required CollegeModel model}) async {
    final url = dotenv.env[UrlKey.urlKey] ?? '';

    await dio.post(
      "${url}college/",
      data: model.toJson(),
      options: Options(headers: await AutorisationToken.headers()),
    );
  }

  Future<List<CollegeEntity>> getCollegeData() async {
    final url = dotenv.env[UrlKey.urlKey] ?? '';

    final response = await dio.get("${url}college/");

    final List<dynamic> data = response.data;

    return data.map((e) => CollegeModel.fromJson(e)).toList();
  }

  Future<void> updateCollege({
    required int id,
    required CollegeModel model,
  }) async {
    final url = dotenv.env[UrlKey.urlKey] ?? '';

    await dio.put(
      "${url}college/$id/",
      data: model.toJson(),
      options: Options(headers: await AutorisationToken.headers()),
    );
  }
}
