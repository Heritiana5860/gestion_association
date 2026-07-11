import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/network/api_endpoints.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/data/models/event_model.dart';

abstract class EventDatasource {
  Future<List<EventModel>> events(String year);
  Future<EventModel> eventDetail(int id);
  Future<void> addEvent(EventModel model);
  Future<void> addComingMember({
    required int eventId,
    required String memberCde,
  });
}

class EventDatasourceImpl implements EventDatasource {
  final Dio dio;

  const EventDatasourceImpl({required this.dio});

  @override
  Future<List<EventModel>> events(String year) async {
    final response = await dio.get(
      ApiEndpoints.event,
      queryParameters: {'year': year},
    );

    final List<dynamic> data = response.data;

    return data.map((e) => EventModel.fromJson(e)).toList();
  }

  @override
  Future<EventModel> eventDetail(int id) async {
    final response = await dio.get("${ApiEndpoints.event}$id/");

    debugPrint("Event detail: $response");

    return EventModel.fromJson(response.data);
  }

  @override
  Future<void> addEvent(EventModel model) async {
    await dio.post(ApiEndpoints.event, data: model.toJson());
  }

  @override
  Future<void> addComingMember({
    required int eventId,
    required String memberCde,
  }) async {
    final response = await dio.post(
      "${ApiEndpoints.event}$eventId${ApiEndpoints.comingMember}",
      data: {"member_cde": memberCde},
    );

    final data = response.data;
    if (data is Map && data.containsKey('error')) {
      throw Exception(data['error']);
    }
  }
}
