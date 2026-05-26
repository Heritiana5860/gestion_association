import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/network_error.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/server_error.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/validation_error.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/data/datasources/event_datasource.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/domain/entities/event_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/domain/repositories/event_repository.dart';

class EventRepositoryImpl implements EventRepository {
  final EventDatasource datasource;

  const EventRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, List<EventEntity>>> fetchEvent() async {
    try {
      final response = await datasource.events();
      return Right(response);
    } on SocketException {
      return Left(NetworkError());
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        return Left(ValidationError(e.response?.data));
      }
      return Left(ServerError());
    } on Exception {
      return Left(ServerError());
    }
  }

  @override
  Future<Either<Failure, EventEntity>> fetchDetailEvent({
    required int id,
  }) async {
    try {
      final response = await datasource.eventDetail(id: id);
      return Right(response);
    } on SocketException {
      return Left(NetworkError());
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        return Left(ValidationError(e.response?.data));
      }
      return Left(ServerError());
    } on Exception {
      return Left(ServerError());
    }
  }
}
