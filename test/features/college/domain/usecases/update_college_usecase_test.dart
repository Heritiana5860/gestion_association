import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/entities/college_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/repositories/college_repository.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/usecases/college/update_college_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockUpdateCollegeRepository extends Mock implements CollegeRepository {}

void main() {
  late MockUpdateCollegeRepository mockRepository;
  late UpdateCollegeUsecase usecase;

  setUp(() {
    mockRepository = MockUpdateCollegeRepository();
    usecase = UpdateCollegeUsecase(repository: mockRepository);
  });

  const entity = CollegeEntity(
    nom: "TOTO",
    contact: "0345566677",
    address: "address",
    etablissement: "etablissement",
    niveau: "L2",
    nomPromotion: "nomPromotion",
    year: "2026",
  );

  const id = 1;

  test("should return void when college updated successful", () async {
    when(
      () => mockRepository.updateCollege(id: id, entity: entity),
    ).thenAnswer((_) async => const Right(null));

    final result = await usecase.callCollegeUpdate(id: id, entity: entity);

    expect(result, const Right(null));
    verify(
      () => mockRepository.updateCollege(id: id, entity: entity),
    ).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test("should return Failure when update college fails", () async {
    const tFailure = ServerFailure(
      message: "Erreur lors de la mise à jour de college.",
    );

    when(
      () => mockRepository.updateCollege(id: id, entity: entity),
    ).thenAnswer((_) async => const Left(tFailure));

    final result = await usecase.callCollegeUpdate(id: id, entity: entity);

    expect(result, const Left(tFailure));
    verify(() => mockRepository.updateCollege(id: id, entity: entity));
  });
}
