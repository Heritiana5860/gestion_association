import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/obligation/domain/entities/obligation_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/obligation/domain/repositories/add_obligation_repository.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/obligation/domain/usecases/add_obligation_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockAddObligationRepository extends Mock
    implements AddObligationRepository {}

void main() {
  late MockAddObligationRepository mockRepository;
  late AddObligationUsecase usecase;

  setUp(() {
    mockRepository = MockAddObligationRepository();
    usecase = AddObligationUsecase(repository: mockRepository);
  });

  const entity = ObligationEntity(
    noviceAmountIn: 14000.0,
    noviceAmountExt: 12000.0,
    doyenAncienIn: 9000.0,
    doyenAncienExt: 7000.0,
    year: 2026,
  );

  test("should return void when obligation added successful", () async {
    when(
      () => mockRepository.addObligation(entity),
    ).thenAnswer((_) async => const Right(null));

    final result = await usecase.callAdd(entity);

    expect(result, const Right(null));
    verify(() => mockRepository.addObligation(entity)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test("should return Failure when add obligation fails", () async {
    const tFailure = ServerFailure(
      message: "Erreur lors de l'ajout d'obligation.",
    );

    when(
      () => mockRepository.addObligation(entity),
    ).thenAnswer((_) async => const Left(tFailure));

    final result = await usecase.callAdd(entity);

    expect(result, const Left(tFailure));
    verify(() => mockRepository.addObligation(entity));
  });
}
