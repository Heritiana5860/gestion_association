import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/entities/cadre_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/repositories/cadre_repository.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/usecases/cadre/update_cadre_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockUpdateCadreRepository extends Mock implements CadreRepository {}

void main() {
  late MockUpdateCadreRepository mockRepository;
  late UpdateCadreUsecase usecase;

  setUp(() {
    mockRepository = MockUpdateCadreRepository();
    usecase = UpdateCadreUsecase(repository: mockRepository);
  });

  const entity = CadreEntity(
    nom: 'TOTO',
    fonction: 'Fonctionnaire',
    contact: '0345678900',
    address: 'Anjoma',
  );
  const id = 1;

  test("should return void when cadre updated successful", () async {
    when(
      () => mockRepository.updateCadre(id: id, entity: entity),
    ).thenAnswer((_) async => const Right(null));

    final result = await usecase.callCadreUpdate(id: id, entity: entity);

    expect(result, const Right(null));
    verify(() => mockRepository.updateCadre(id: id, entity: entity)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test("should return Failure when update cadre fails", () async {
    const tFailure = ServerFailure(
      message: "Erreur lors de la mise à jour de cadre.",
    );

    when(
      () => mockRepository.updateCadre(id: id, entity: entity),
    ).thenAnswer((_) async => const Left(tFailure));

    final result = await usecase.callCadreUpdate(id: id, entity: entity);

    expect(result, const Left(tFailure));
    verify(() => mockRepository.updateCadre(id: id, entity: entity));
  });
}
