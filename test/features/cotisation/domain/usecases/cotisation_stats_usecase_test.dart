import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/domain/entities/cotisation_stats_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/domain/repositories/cotisation_stats_repository.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/domain/usecases/cotisation_stats_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockCotisationStatsRepository extends Mock
    implements CotisationStatsRepository {}

void main() {
  late MockCotisationStatsRepository mockRepository;
  late CotisationStatsUsecase usecase;

  setUp(() {
    mockRepository = MockCotisationStatsRepository();
    usecase = CotisationStatsUsecase(repository: mockRepository);
  });

  const tStatsEntity = CotisationStatsEntity(
    total: 300,
    paid: 210,
    notPaid: 90,
    novicesPaid: 80,
    novicesNotPaid: 20,
    anciensPaid: 60,
    anciensNotPaid: 40,
    doyenPaid: 20,
    doyenNotPaid: 80,
    paidPercentage: 65.0,
    notPaidPercentage: 35.0,
    novicesPaidPercentage: 56.0,
    novicesNotPaidPercentage: 44.0,
    anciensPaidPercentage: 30.0,
    anciensNotPaidPercentage: 70.0,
    doyensPaidPercentage: 50.0,
    doyensNotPaidPercentage: 50.0,
  );

  const tYear = "2026";

  test(
    "should return CotisationStatsEntity when cotisation stats succesful",
    () async {
      // ARRANGE
      when(
        () => mockRepository.cotisationStats(year: tYear),
      ).thenAnswer((_) async => const Right(tStatsEntity));

      // ACT
      final result = await usecase.call(year: tYear);

      // ASSERT
      expect(result, const Right(tStatsEntity));
      verify(() => mockRepository.cotisationStats(year: tYear)).called(1);
      verifyNoMoreInteractions(mockRepository);
    },
  );

  test("should return Failure when cotisation stats fails", () async {
    const tFailure = ServerFailure(
      message: "Erreur lors de la recuperation de cotisation stats",
      statusCode: 401,
    );
    // ARRANGE
    when(
      () => mockRepository.cotisationStats(year: tYear),
    ).thenAnswer((_) async => const Left(tFailure));

    // ACT
    final result = await usecase.call(year: tYear);

    // ASSERT
    expect(result, const Left(tFailure));
    verify(() => mockRepository.cotisationStats(year: tYear));
  });
}
