import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/domain/repositories/event_repository.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/domain/usecases/coming_member_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockComingMemberRepository extends Mock implements EventRepository {}

void main() {
  late MockComingMemberRepository mockRepository;
  late ComingMemberUsecase usecase;

  setUp(() {
    mockRepository = MockComingMemberRepository();
    usecase = ComingMemberUsecase(repository: mockRepository);
  });

  const eventId = 1;
  const memberCde = "1234";

  test("should return String when coming member added successful", () async {
    when(
      () => mockRepository.addComingMember(
        eventId: eventId,
        memberCde: memberCde,
      ),
    ).thenAnswer((_) async => const Right(null));

    final result = await usecase.callAddComingMember(
      eventId: eventId,
      memberCde: memberCde,
    );

    expect(result, const Right(null));
    verify(
      () => mockRepository.addComingMember(
        eventId: eventId,
        memberCde: memberCde,
      ),
    ).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test("should return Failure when add coming member fails", () async {
    const tFailure = ServerFailure(message: "Erreur lors de l'ajout.");

    when(
      () => mockRepository.addComingMember(
        eventId: eventId,
        memberCde: memberCde,
      ),
    ).thenAnswer((_) async => const Left(tFailure));

    final result = await usecase.callAddComingMember(
      eventId: eventId,
      memberCde: memberCde,
    );

    expect(result, const Left(tFailure));
    verify(
      () => mockRepository.addComingMember(
        eventId: eventId,
        memberCde: memberCde,
      ),
    );
  });
}
