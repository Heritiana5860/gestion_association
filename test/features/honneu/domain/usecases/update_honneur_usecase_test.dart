import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/entities/honneur_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/repositories/honneur_repository.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/usecases/honneur/update_honneur_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockUpdateHonneurRepository extends Mock implements HonneurRepository {}

void main() {
  late MockUpdateHonneurRepository mockRepository;
  late UpdateHonneurUsecase usecase;

  setUp(() {
    mockRepository = MockUpdateHonneurRepository();
    usecase = UpdateHonneurUsecase(repository: mockRepository);
  });

  const entity = HonneurEntity(
    nom: "TOTO",
    fonction: "fonction",
    contact: "0345566677",
    year: "2026",
    address: "address",
  );

  const id = 1;

  test("should return void when honneur updated successful", () async {
    when(
      () => mockRepository.updateHonneur(id: id, entity: entity),
    ).thenAnswer((_) async => const Right(null));

    final result = await usecase.callUpdateHonneur(id: id, entity: entity);

    expect(result, const Right(null));
    verify(
      () => mockRepository.updateHonneur(id: id, entity: entity),
    ).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test("should return Failure when update honneur fails", () async {
    const tFailure = ServerFailure(
      message: "Erreur lors de la mise à jour de honneur.",
    );

    when(
      () => mockRepository.updateHonneur(id: id, entity: entity),
    ).thenAnswer((_) async => const Left(tFailure));

    final result = await usecase.callUpdateHonneur(id: id, entity: entity);

    expect(result, const Left(tFailure));
    verify(() => mockRepository.updateHonneur(id: id, entity: entity));
  });
}
