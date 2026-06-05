import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/keys/url_key.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/data/models/event_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/domain/entities/event_entity.dart';

class EventDatasource {
  final Dio dio;

  const EventDatasource({required this.dio});

  Future<List<EventEntity>> events() async {
    final url = dotenv.env[UrlKey.urlKey] ?? "";

    final response = await dio.get("${url}event/");
    final List<dynamic> data = response.data;

    return data.map((e) => EventModel.fromJson(e)).toList();
  }

  Future<EventEntity> eventDetail({required int id}) async {
    final url = dotenv.env[UrlKey.urlKey] ?? "";

    final response = await dio.get("${url}event/$id/");

    debugPrint("response: $response");
    return EventModel.fromJson(response.data);
  }

  Future<void> submit({required EventModel model}) async {
    final url = dotenv.env[UrlKey.urlKey] ?? "";

    await dio.post("${url}event/", data: model.toJson());
  }
}
