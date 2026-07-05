import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/dio_exception_mapper.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/data/datasources/event_datasource.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/data/models/event_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/domain/entities/event_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/domain/repositories/event_repository.dart';

class EventRepositoryImpl implements EventRepository {
  final EventDatasource datasource;

  const EventRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, List<EventEntity>>> events(String year) async {
    try {
      final response = await datasource.events(year);
      return Right(response);
    } on DioException catch (e) {
      return Left(mapDioExceptionToFailure(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, EventEntity>> eventDetail(int id) async {
    try {
      final response = await datasource.eventDetail(id);
      return Right(response);
    } on DioException catch (e) {
      return Left(mapDioExceptionToFailure(e));
    } catch (e) {
      return Left(ServerFailure(message: ""));
    }
  }

  @override
  Future<Either<Failure, void>> addEvent(EventEntity entity) async {
    try {
      final model = EventModel(
        eventName: entity.eventName,
        eventDescription: entity.eventDescription,
        eventDate: entity.eventDate,
        startTime: entity.startTime,
        endTime: entity.endTime,
        year: entity.year,
      );

      final response = await datasource.addEvent(model);
      return Right(response);
    } on DioException catch (e) {
      return Left(mapDioExceptionToFailure(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addComingMember({
    required int eventId,
    required String memberCde,
  }) async {
    try {
      await datasource.addComingMember(eventId: eventId, memberCde: memberCde);

      return const Right(null);
    } on DioException catch (e) {
      return Left(mapDioExceptionToFailure(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
