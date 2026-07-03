import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/domain/entities/member_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/domain/repositories/member_repository.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/domain/usecases/member_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockMembersRepository extends Mock implements MemberRepository {}

void main() {
  late MockMembersRepository mockRepository;
  late MemberUsecase usecase;

  setUp(() {
    mockRepository = MockMembersRepository();
    usecase = MemberUsecase(repository: mockRepository);
  });

  const tEntity = MemberEntity(
    fullName: "TORO Beto",
    numberPhone: "0345678900",
    isInside: false,
    cde: "1234",
    address: "Andrainjato",
    school: "Emit",
    level: "M1",
    statut: "Novice",
  );

  const year = "2026";

  test("should return List<MemberEntity> when get member successful", () async {
    when(
      () => mockRepository.members(year: year),
    ).thenAnswer((_) async => const Right([tEntity]));

    final result = await usecase.call(year: year);

    expect(result, const Right([tEntity]));
    verify(() => mockRepository.members(year: year)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test("should return Failure when get member fails", () async {
    const tFailure = ServerFailure(
      message: "Erreur lors de la recuperation d'un membre.",
    );

    when(
      () => mockRepository.members(year: year),
    ).thenAnswer((_) async => const Left(tFailure));

    final result = await usecase.call(year: year);

    expect(result, const Left(tFailure));
    verify(() => mockRepository.members(year: year));
  });
}
