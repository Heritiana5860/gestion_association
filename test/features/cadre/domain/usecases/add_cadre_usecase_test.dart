import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/entities/cadre_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/repositories/cadre_repository.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/usecases/cadre/add_cadre_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockAddCadreRepository extends Mock implements CadreRepository {}

void main() {
  late MockAddCadreRepository mockRepository;
  late AddCadreUsecase usecase;

  setUp(() {
    mockRepository = MockAddCadreRepository();
    usecase = AddCadreUsecase(repository: mockRepository);
  });

  const entity = CadreEntity(
    nom: 'TOTO',
    fonction: 'Fonctionnaire',
    contact: '0345678900',
    address: 'Anjoma',
  );

  test("should return void when cadre added successful", () async {
    when(
      () => mockRepository.addCadre(entity),
    ).thenAnswer((_) async => const Right(null));

    final result = await usecase.call(entity);

    expect(result, const Right(null));
    verify(() => mockRepository.addCadre(entity)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test("should return Failure when add cadre fails", () async {
    const tFailure = ServerFailure(message: "Erreur lors de l'ajout de cadre.");

    when(
      () => mockRepository.addCadre(entity),
    ).thenAnswer((_) async => const Left(tFailure));

    final result = await usecase.call(entity);

    expect(result, const Left(tFailure));
    verify(() => mockRepository.addCadre(entity));
  });
}
