import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/entities/cadre_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/repositories/cadre_repository.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/usecases/cadre/cadre_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockCadresRepository extends Mock implements CadreRepository {}

void main() {
  late MockCadresRepository mockRepository;
  late CadreUsecase usecase;

  setUp(() {
    mockRepository = MockCadresRepository();
    usecase = CadreUsecase(repository: mockRepository);
  });

  const entity = CadreEntity(
    nom: 'TOTO',
    fonction: 'Fonctionnaire',
    contact: '0345678900',
    address: 'Anjoma',
  );

  test("should return List<CadreEntity> when get cadre successful", () async {
    when(
      () => mockRepository.cadres(),
    ).thenAnswer((_) async => const Right([entity]));

    final result = await usecase.callCadre();

    expect(result, const Right([entity]));
    verify(() => mockRepository.cadres()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test("should return Failure when get cadre fails", () async {
    const tFailure = ServerFailure(
      message: "Erreur lors de la recuperation de cadre.",
    );

    when(
      () => mockRepository.cadres(),
    ).thenAnswer((_) async => const Left(tFailure));

    final result = await usecase.callCadre();

    expect(result, const Left(tFailure));
    verify(() => mockRepository.cadres());
  });
}
