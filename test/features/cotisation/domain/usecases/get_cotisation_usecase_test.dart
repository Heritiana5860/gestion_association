import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/domain/entities/cotisation_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/domain/repositories/cotisation_repository.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/domain/usecases/get_cotisation_usecase.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/domain/entities/member_entity.dart';
import 'package:mocktail/mocktail.dart';

class MockCotisationRepository extends Mock implements CotisationRepository {}

void main() {
  late MockCotisationRepository mockRepository;
  late GetCotisationUsecase usecase;

  setUp(() {
    mockRepository = MockCotisationRepository();
    usecase = GetCotisationUsecase(repository: mockRepository);
  });

  const tCotisationEntity = CotisationEntity(
    amount: 9000.0,
    isUpdate: "Dernière mise à jour le 10 juillet 2026",
    year: "2026",
    member: MemberEntity(
      fullName: "TORO Beto",
      numberPhone: "0345678900",
      isInside: true,
      cde: "3456",
      address: "Andrainjato",
      school: "Medecine",
      level: "L3",
      statut: "Doyen(es)",
    ),
  );

  const tYear = "2026";

  test(
    "should return List<CotisationEntity> when get cotisation successful",
    () async {
      when(
        () => mockRepository.cotisations(year: tYear, search: null),
      ).thenAnswer((_) async => const Right([tCotisationEntity]));

      final result = await usecase.call(year: tYear);

      expect(result, const Right([tCotisationEntity]));
      verify(
        () => mockRepository.cotisations(year: tYear, search: null),
      ).called(1);
      verifyNoMoreInteractions(mockRepository);
    },
  );

  test("should return Failure when get cotisation fails", () async {
    const tFailure = ServerFailure(
      message: "Erreur lors de la recuperation des cotisations",
      statusCode: 401,
    );

    when(
      () => mockRepository.cotisations(year: tYear),
    ).thenAnswer((_) async => Left(tFailure));

    final result = await usecase.call(year: tYear);

    expect(result, const Left(tFailure));
    verify(() => mockRepository.cotisations(year: tYear));
  });
}
