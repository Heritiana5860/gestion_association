import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/domain/entities/member_stats_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/domain/repositories/member_stats_repository.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/domain/usecases/member_stats_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockMemberStatsRepository extends Mock implements MemberStatsRepository {}

void main() {
  late MockMemberStatsRepository mockRepository;
  late MemberStatsUsecase usecase;

  setUp(() {
    mockRepository = MockMemberStatsRepository();
    usecase = MemberStatsUsecase(repository: mockRepository);
  });

  const entity = MemberStatsEntity(
    total: 300,
    novices: 100,
    anciens: 100,
    doyens: 100,
    novicesPourcentage: 30.0,
    anciensPourcentage: 30.0,
    doyensPourcantage: 30.0,
  );

  test("should return MemberStatsEntity when get stats successful", () async {
    when(
      () => mockRepository.memberStats(),
    ).thenAnswer((_) async => const Right(entity));

    final result = await usecase.call();

    expect(result, const Right(entity));
    verify(() => mockRepository.memberStats()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test("should return Failure when get stats fails", () async {
    const tFailure = ServerFailure(
      message: "Erreur lors de la recuperation des stats.",
    );

    when(
      () => mockRepository.memberStats(),
    ).thenAnswer((_) async => const Left(tFailure));

    final result = await usecase.call();

    expect(result, const Left(tFailure));
    verify(() => mockRepository.memberStats());
  });
}
