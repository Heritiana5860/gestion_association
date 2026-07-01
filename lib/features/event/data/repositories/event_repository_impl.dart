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
  Future<Either<Failure, List<EventEntity>>> fetchEvent({
    required String year,
  }) async {
    try {
      final response = await datasource.events(year: year);
      return Right(response);
    } on DioException catch (e) {
      return Left(mapDioExceptionToFailure(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, EventEntity>> fetchDetailEvent({
    required int id,
  }) async {
    try {
      final response = await datasource.eventDetail(id: id);
      return Right(response);
    } on DioException catch (e) {
      return Left(mapDioExceptionToFailure(e));
    } catch (e) {
      return Left(ServerFailure(message: ""));
    }
  }

  @override
  Future<Either<Failure, void>> submitEvent({required EventModel model}) async {
    try {
      final response = await datasource.submit(model: model);
      return Right(response);
    } on DioException catch (e) {
      return Left(mapDioExceptionToFailure(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> addComingMember({
    required int eventId,
    required String memberCde,
  }) async {
    try {
      final response = await datasource.addComingMember(
        eventId: eventId,
        memberCde: memberCde,
      );

      if (response.containsKey('status')) {
        return Right(response['status'] as String);
      }
      if (response.containsKey('Closed')) {
        return Left(ServerFailure(message: response['Closed']));
      }
      if (response.containsKey('error')) {
        return Left(ServerFailure(message: response['error']));
      }

      return const Right("Membre ajouté");
    } on DioException catch (e) {
      return Left(mapDioExceptionToFailure(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
