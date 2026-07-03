import 'package:dartz/dartz.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/domain/entities/event_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/domain/repositories/event_repository.dart';

class AddEventUsecase {
  final EventRepository repository;

  const AddEventUsecase({required this.repository});

  Future<Either<Failure, void>> addEventcall(EventEntity entity) {
    return repository.addEvent(entity);
  }
}
