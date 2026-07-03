import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/domain/entities/add_cotisation_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/domain/repositories/cotisation_repository.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/domain/usecases/add_cotisation_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockAddCotisationRepository extends Mock
    implements CotisationRepository {}

void main() {
  late MockAddCotisationRepository mockRepository;
  late AddCotisationUsecase usecase;

  setUp(() {
    mockRepository = MockAddCotisationRepository();
    usecase = AddCotisationUsecase(repository: mockRepository);
  });

  const entity = AddCotisationEntity(id: 1, amount: 9000.0, year: "2026");

  test("should return void when cotisation added successful", () async {
    when(
      () => mockRepository.addCotisation(entity),
    ).thenAnswer((_) async => const Right(null));

    final result = await usecase.addCotisationCall(entity);

    expect(result, const Right(null));
    verify(() => mockRepository.addCotisation(entity));
    verifyNoMoreInteractions(mockRepository);
  });

  test("should return Failure when add cotisation fails", () async {
    const tFailure = ServerFailure(
      message: "Erreur lors de l'ajout cotisation",
      statusCode: 401,
    );

    when(
      () => mockRepository.addCotisation(entity),
    ).thenAnswer((_) async => Left(tFailure));

    final result = await usecase.addCotisationCall(entity);

    expect(result, const Left(tFailure));
    verify(() => mockRepository.addCotisation(entity));
  });
}
