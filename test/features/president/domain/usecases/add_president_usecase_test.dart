import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/entities/president_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/repositories/president_repository.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/usecases/president/add_president_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockAddPresidentRepository extends Mock implements PresidentRepository {}

void main() {
  late MockAddPresidentRepository mockRepository;
  late AddPresidentUsecase usecase;

  setUp(() {
    mockRepository = MockAddPresidentRepository();
    usecase = AddPresidentUsecase(repository: mockRepository);
  });

  const entity = PresidentEntity(
    nom: "TOT",
    contact: "0345566677",
    year: "2026",
    bio: "President bio",
  );

  test("should return void when president added successful", () async {
    when(
      () => mockRepository.addPresident(entity),
    ).thenAnswer((_) async => const Right(null));

    final result = await usecase.call(entity);

    expect(result, const Right(null));
    verify(() => mockRepository.addPresident(entity)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test("should return Failure when add president fails", () async {
    const tFailure = ServerFailure(
      message: "Erreur lors de l'ajout de president.",
    );

    when(
      () => mockRepository.addPresident(entity),
    ).thenAnswer((_) async => const Left(tFailure));

    final result = await usecase.call(entity);

    expect(result, const Left(tFailure));
    verify(() => mockRepository.addPresident(entity));
  });
}
