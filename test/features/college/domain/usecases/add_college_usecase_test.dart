import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/entities/college_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/repositories/college_repository.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/usecases/college/add_college_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockAddCollegeRepository extends Mock implements CollegeRepository {}

void main() {
  late MockAddCollegeRepository mockRepository;
  late AddCollegeUsecase usecase;

  setUp(() {
    mockRepository = MockAddCollegeRepository();
    usecase = AddCollegeUsecase(repository: mockRepository);
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

  test("should return void when college added successful", () async {
    when(
      () => mockRepository.addCollege(entity),
    ).thenAnswer((_) async => const Right(null));

    final result = await usecase.callAddCollege(entity);

    expect(result, const Right(null));
    verify(() => mockRepository.addCollege(entity)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test("should return Failure when add college fails", () async {
    const tFailure = ServerFailure(
      message: "Erreur lors de l'ajout de college.",
    );

    when(
      () => mockRepository.addCollege(entity),
    ).thenAnswer((_) async => const Left(tFailure));

    final result = await usecase.callAddCollege(entity);

    expect(result, const Left(tFailure));
    verify(() => mockRepository.addCollege(entity));
  });
}
