import 'package:dartz/dartz.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/data/models/event_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/domain/entities/event_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/domain/repositories/event_repository.dart';

class EventUsecase {
  final EventRepository repository;

  const EventUsecase({required this.repository});

  Future<Either<Failure, List<EventEntity>>> call() {
    return repository.fetchEvent();
  }

  Future<Either<Failure, EventEntity>> callDetail({required int id}) {
    return repository.fetchDetailEvent(id: id);
  }

  Future<Either<Failure, void>> callSubmit({required EventModel model}) {
    return repository.submitEvent(model: model);
  }

  Future<Either<Failure, String>> callAddComingMember({
    required int eventId,
    required String memberCde,
  }) {
    return repository.addComingMember(eventId: eventId, memberCde: memberCde);
  }
}
