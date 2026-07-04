import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/entities/honneur_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/repositories/honneur_repository.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/usecases/honneur/honneur_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockHonneurRepository extends Mock implements HonneurRepository {}

void main() {
  late MockHonneurRepository mockRepository;
  late HonneurUsecase usecase;

  setUp(() {
    mockRepository = MockHonneurRepository();
    usecase = HonneurUsecase(repository: mockRepository);
  });

  const entity = HonneurEntity(
    nom: "TOTO",
    fonction: "fonction",
    contact: "0345566677",
    year: "2026",
    address: "address",
  );

  test(
    "should return List<HonneurEntity> when get honneur successful",
    () async {
      when(
        () => mockRepository.honneurs(),
      ).thenAnswer((_) async => const Right([entity]));

      final result = await usecase.callFetchHonneur();

      expect(result, const Right([entity]));
      verify(() => mockRepository.honneurs()).called(1);
      verifyNoMoreInteractions(mockRepository);
    },
  );

  test("should return Failure when get honneur fails", () async {
    const tFailure = ServerFailure(
      message: "Erreur lors de la recuperation de honneur.",
    );

    when(
      () => mockRepository.honneurs(),
    ).thenAnswer((_) async => const Left(tFailure));

    final result = await usecase.callFetchHonneur();

    expect(result, const Left(tFailure));
    verify(() => mockRepository.honneurs());
  });
}
