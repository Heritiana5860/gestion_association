import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/entities/president_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/repositories/president_repository.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/usecases/president/president_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockPresidentRepository extends Mock implements PresidentRepository {}

void main() {
  late MockPresidentRepository mockRepository;
  late PresidentUsecase usecase;

  setUp(() {
    mockRepository = MockPresidentRepository();
    usecase = PresidentUsecase(repository: mockRepository);
  });

  const entity = PresidentEntity(
    nom: "TOT",
    contact: "0345566677",
    year: "2026",
    bio: "President bio",
  );

  test(
    "should return List<PresidentEntity> when get president successful",
    () async {
      when(
        () => mockRepository.presidents(),
      ).thenAnswer((_) async => const Right([entity]));

      final result = await usecase.fetchPresidentList();

      expect(result, const Right([entity]));
      verify(() => mockRepository.presidents()).called(1);
      verifyNoMoreInteractions(mockRepository);
    },
  );

  test("should return Failure when get president fails", () async {
    const tFailure = ServerFailure(
      message: "Erreur lors de la recuperation de president.",
    );

    when(
      () => mockRepository.presidents(),
    ).thenAnswer((_) async => const Left(tFailure));

    final result = await usecase.fetchPresidentList();

    expect(result, const Left(tFailure));
    verify(() => mockRepository.presidents());
  });
}
