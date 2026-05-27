import 'package:dartz/dartz.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/data/models/event_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/domain/entities/event_entity.dart';

abstract class EventRepository {
  Future<Either<Failure, List<EventEntity>>> fetchEvent();
  Future<Either<Failure, EventEntity>> fetchDetailEvent({required int id});
  Future<Either<Failure, void>> submitEvent({required EventModel model});
}
