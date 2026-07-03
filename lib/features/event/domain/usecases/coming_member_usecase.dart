import 'package:dartz/dartz.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/domain/repositories/event_repository.dart';

class ComingMemberUsecase {
  final EventRepository repository;

  const ComingMemberUsecase({required this.repository});

  Future<Either<Failure, String>> callAddComingMember({
    required int eventId,
    required String memberCde,
  }) {
    return repository.addComingMember(eventId: eventId, memberCde: memberCde);
  }
}
