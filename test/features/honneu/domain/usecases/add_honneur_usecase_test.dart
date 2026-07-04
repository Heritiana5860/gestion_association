import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/entities/honneur_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/repositories/honneur_repository.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/usecases/honneur/add_honneur_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockAddHonneurRepository extends Mock implements HonneurRepository {}

void main() {
  late MockAddHonneurRepository mockRepository;
  late AddHonneurUsecase usecase;

  setUp(() {
    mockRepository = MockAddHonneurRepository();
    usecase = AddHonneurUsecase(repository: mockRepository);
  });

  const entity = HonneurEntity(
    nom: "TOTO",
    fonction: "fonction",
    contact: "0345566677",
    year: "2026",
    address: "address",
  );

  test("should return void when honneur added successful", () async {
    when(
      () => mockRepository.addHonneur(entity),
    ).thenAnswer((_) async => const Right(null));

    final result = await usecase.call(entity: entity);

    expect(result, const Right(null));
    verify(() => mockRepository.addHonneur(entity)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test("should return Failure when add honneur fails", () async {
    const tFailure = ServerFailure(
      message: "Erreur lors de l'ajout de honneur.",
    );

    when(
      () => mockRepository.addHonneur(entity),
    ).thenAnswer((_) async => const Left(tFailure));

    final result = await usecase.call(entity: entity);

    expect(result, const Left(tFailure));
    verify(() => mockRepository.addHonneur(entity));
  });
}
