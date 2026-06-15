import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/keys/url_key.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/data/models/president_model.dart';

class PresidentDatasource {
  final Dio dio;

  const PresidentDatasource({required this.dio});

  Future<void> president({required PresidentModel model}) async {
    final url = dotenv.env[UrlKey.urlKey] ?? "";

    await dio.post(url, data: model.toJson());
  }
}
