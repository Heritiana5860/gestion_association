import 'package:dartz/dartz.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/domain/entities/event_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/domain/repositories/event_repository.dart';

class EventUsecase {
  final EventRepository repository;

  const EventUsecase({required this.repository});

  Future<Either<Failure, List<EventEntity>>> call(String year) {
    return repository.events(year);
  }

  Future<Either<Failure, EventEntity>> callDetail(int id) {
    return repository.eventDetail(id);
  }

  Future<Either<Failure, void>> callSubmit(EventEntity entity) {
    return repository.addEvent(entity);
  }

  Future<Either<Failure, String>> callAddComingMember({
    required int eventId,
    required String memberCde,
  }) {
    return repository.addComingMember(eventId: eventId, memberCde: memberCde);
  }
}
