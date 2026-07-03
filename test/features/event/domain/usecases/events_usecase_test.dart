import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/domain/entities/event_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/domain/repositories/event_repository.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/domain/usecases/event_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockEventsRepository extends Mock implements EventRepository {}

void main() {
  late MockEventsRepository mockRepository;
  late EventUsecase usecase;

  setUp(() {
    mockRepository = MockEventsRepository();
    usecase = EventUsecase(repository: mockRepository);
  });

  const tEntity = EventEntity(
    eventName: "A.G",
    eventDescription: "Assemblé Général",
    eventDate: "03/07/2026",
    startTime: "14h 00",
    endTime: "16H 00",
    year: 2026,
  );

  const tYear = "2026";

  test("should return List<EventEntity> when get events successful", () async {
    when(
      () => mockRepository.events(tYear),
    ).thenAnswer((_) async => const Right([tEntity]));

    final result = await usecase.call(tYear);

    expect(result, const Right([tEntity]));
    verify(() => mockRepository.events(tYear)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test("should return Failure when get events fails", () async {
    const tFailure = ServerFailure(
      message: "Erreur lors de la recuperation des evenements.",
    );

    when(
      () => mockRepository.events(tYear),
    ).thenAnswer((_) async => const Left(tFailure));

    final result = await usecase.call(tYear);

    expect(result, const Left(tFailure));
    verify(() => mockRepository.events(tYear));
  });
}
