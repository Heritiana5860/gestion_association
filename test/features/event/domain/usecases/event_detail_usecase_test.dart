import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/domain/entities/event_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/domain/repositories/event_repository.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/domain/usecases/event_detail_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockEventDetailRepository extends Mock implements EventRepository {}

void main() {
  late MockEventDetailRepository mockRepository;
  late EventDetailUsecase usecase;

  setUp(() {
    mockRepository = MockEventDetailRepository();
    usecase = EventDetailUsecase(repository: mockRepository);
  });

  const tEntity = EventEntity(
    eventName: "A.G",
    eventDescription: "Assemblé Général",
    eventDate: "03/07/2026",
    startTime: "14h 00",
    endTime: "16H 00",
    year: 2026,
  );

  const tId = 1;

  test("should return EventEntity when get events successful", () async {
    when(
      () => mockRepository.eventDetail(tId),
    ).thenAnswer((_) async => const Right(tEntity));

    final result = await usecase.callDetail(tId);

    expect(result, const Right(tEntity));
    verify(() => mockRepository.eventDetail(tId)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test("should return Failure when get detail event fails", () async {
    const tFailure = ServerFailure(
      message: "Erreur lors de la recuperation de la detail de l'evenement.",
    );

    when(
      () => mockRepository.eventDetail(tId),
    ).thenAnswer((_) async => const Left(tFailure));

    final result = await usecase.callDetail(tId);

    expect(result, const Left(tFailure));
    verify(() => mockRepository.eventDetail(tId));
  });
}
