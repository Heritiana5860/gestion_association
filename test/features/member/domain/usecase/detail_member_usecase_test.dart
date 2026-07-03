import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/domain/entities/member_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/domain/repositories/member_repository.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/domain/usecases/detail_member_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockDetailMemebrRepository extends Mock implements MemberRepository {}

void main() {
  late MockDetailMemebrRepository mockRepository;
  late DetailMemberUsecase usecase;

  setUp(() {
    mockRepository = MockDetailMemebrRepository();
    usecase = DetailMemberUsecase(repository: mockRepository);
  });

  const entity = MemberEntity(
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
  const id = 1;

  test(
    "should return MemberEntity when get detail member successful",
    () async {
      when(
        () => mockRepository.detailMember(id: id, year: year),
      ).thenAnswer((_) async => const Right(entity));

      final result = await usecase.callDetailMember(id: id, year: year);

      expect(result, const Right(entity));
      verify(() => mockRepository.detailMember(id: id, year: year)).called(1);
      verifyNoMoreInteractions(mockRepository);
    },
  );

  test("should return Failure when get detail member fails", () async {
    const tFailure = ServerFailure(
      message: "Erreur lors de la recuperation de detail d'un membre.",
    );

    when(
      () => mockRepository.detailMember(id: id, year: year),
    ).thenAnswer((_) async => const Left(tFailure));

    final result = await usecase.callDetailMember(id: id, year: year);

    expect(result, const Left(tFailure));
    verify(() => mockRepository.detailMember(id: id, year: year));
  });
}
