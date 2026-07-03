import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/domain/entities/event_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/domain/repositories/event_repository.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/domain/usecases/add_event_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockAddEventRepository extends Mock implements EventRepository {}

void main() {
  late MockAddEventRepository mockRepository;
  late AddEventUsecase usecase;

  setUp(() {
    mockRepository = MockAddEventRepository();
    usecase = AddEventUsecase(repository: mockRepository);
  });

  const entity = EventEntity(
    eventName: "A.G",
    eventDescription: "Assemblé Général",
    eventDate: "03/07/2026",
    startTime: "14h 00",
    endTime: "16H 00",
    year: 2026,
  );

  test("should return void when event added successful", () async {
    when(
      () => mockRepository.addEvent(entity),
    ).thenAnswer((_) async => const Right(null));

    final result = await usecase.addEventcall(entity);

    expect(result, const Right(null));
    verify(() => mockRepository.addEvent(entity)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test("should return Failure when add event fails", () async {
    const tFailure = ServerFailure(
      message: "Erreur lors de la création de l'evenement.",
    );

    when(
      () => mockRepository.addEvent(entity),
    ).thenAnswer((_) async => const Left(tFailure));

    final result = await usecase.addEventcall(entity);

    expect(result, const Left(tFailure));
    verify(() => mockRepository.addEvent(entity));
  });
}
