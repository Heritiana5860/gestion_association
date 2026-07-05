import 'package:dartz/dartz.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/domain/entities/event_entity.dart';

abstract class EventRepository {
  Future<Either<Failure, List<EventEntity>>> events(String year);
  Future<Either<Failure, EventEntity>> eventDetail(int id);
  Future<Either<Failure, void>> addEvent(EventEntity entity);
  Future<Either<Failure, void>> addComingMember({
    required int eventId,
    required String memberCde,
  });
}
