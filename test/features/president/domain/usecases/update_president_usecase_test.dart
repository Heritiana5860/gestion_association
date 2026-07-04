import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/entities/president_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/repositories/president_repository.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/usecases/president/update_president_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockUpdatePresidentRepository extends Mock
    implements PresidentRepository {}

void main() {
  late MockUpdatePresidentRepository mockRepository;
  late UpdatePresidentUsecase usecase;

  setUp(() {
    mockRepository = MockUpdatePresidentRepository();
    usecase = UpdatePresidentUsecase(repository: mockRepository);
  });

  const entity = PresidentEntity(
    nom: "TOT",
    contact: "0345566677",
    year: "2026",
    bio: "President bio",
  );

  const id = 1;

  test("should return void when president updated successful", () async {
    when(
      () => mockRepository.updatePresident(id: id, entity: entity),
    ).thenAnswer((_) async => const Right(null));

    final result = await usecase.callPresidentUpdate(id: id, entity: entity);

    expect(result, const Right(null));
    verify(
      () => mockRepository.updatePresident(id: id, entity: entity),
    ).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test("should return Failure when update president fails", () async {
    const tFailure = ServerFailure(
      message: "Erreur lors de la mise à jour de president.",
    );

    when(
      () => mockRepository.updatePresident(id: id, entity: entity),
    ).thenAnswer((_) async => const Left(tFailure));

    final result = await usecase.callPresidentUpdate(id: id, entity: entity);

    expect(result, const Left(tFailure));
    verify(() => mockRepository.updatePresident(id: id, entity: entity));
  });
}
