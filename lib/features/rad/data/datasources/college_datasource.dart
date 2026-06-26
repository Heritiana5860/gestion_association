import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/keys/url_key.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/network/autorisation_token.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/data/models/college_model.dart';

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
}
