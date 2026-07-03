import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/obligation/domain/entities/obligation_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/obligation/domain/repositories/add_obligation_repository.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/obligation/domain/usecases/obligation_usercase.dart';
import 'package:mocktail/mocktail.dart';

class MockObligationRepository extends Mock
    implements AddObligationRepository {}

void main() {
  late MockObligationRepository mockRepository;
  late ObligationUsercase usecase;

  setUp(() {
    mockRepository = MockObligationRepository();
    usecase = ObligationUsercase(repository: mockRepository);
  });

  const entity = ObligationEntity(
    noviceAmountIn: 14000.0,
    noviceAmountExt: 12000.0,
    doyenAncienIn: 9000.0,
    doyenAncienExt: 7000.0,
    year: 2026,
  );

  test(
    "should return List<ObligationEntity> when get obligation successful",
    () async {
      when(
        () => mockRepository.obligations(),
      ).thenAnswer((_) async => const Right([entity]));

      final result = await usecase.call();

      expect(result, const Right([entity]));
      verify(() => mockRepository.obligations()).called(1);
      verifyNoMoreInteractions(mockRepository);
    },
  );

  test("should return Failure when get obligation fails", () async {
    const tFailure = ServerFailure(
      message: "Erreur lors de la recuperation d'obligation.",
    );

    when(
      () => mockRepository.obligations(),
    ).thenAnswer((_) async => const Left(tFailure));

    final result = await usecase.call();

    expect(result, const Left(tFailure));
    verify(() => mockRepository.obligations());
  });
}
