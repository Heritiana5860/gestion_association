import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/entities/college_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/repositories/college_repository.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/usecases/college/college_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockCollegeRepository extends Mock implements CollegeRepository {}

void main() {
  late MockCollegeRepository mockRepository;
  late CollegeUsecase usecase;

  setUp(() {
    mockRepository = MockCollegeRepository();
    usecase = CollegeUsecase(repository: mockRepository);
  });

  const entity = CollegeEntity(
    nom: "TOTO",
    contact: "0345566677",
    address: "address",
    etablissement: "etablissement",
    niveau: "L2",
    nomPromotion: "nomPromotion",
    year: "2026",
  );

  const year = "2026";

  test(
    "should return List<CollegeEntity> when get college successful",
    () async {
      when(
        () => mockRepository.colleges(year),
      ).thenAnswer((_) async => const Right([entity]));

      final result = await usecase.call(year);

      expect(result, const Right([entity]));
      verify(() => mockRepository.colleges(year)).called(1);
      verifyNoMoreInteractions(mockRepository);
    },
  );

  test("should return Failure when get college fails", () async {
    const tFailure = ServerFailure(
      message: "Erreur lors de la recuperation de college.",
    );

    when(
      () => mockRepository.colleges(year),
    ).thenAnswer((_) async => const Left(tFailure));

    final result = await usecase.call(year);

    expect(result, const Left(tFailure));
    verify(() => mockRepository.colleges(year));
  });
}
