import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/domain/entities/member_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/domain/repositories/member_repository.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/domain/usecases/update_member_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockUpdateMemberRepository extends Mock implements MemberRepository {}

void main() {
  late MockUpdateMemberRepository mockRepository;
  late UpdateMemberUsecase usecase;

  setUp(() {
    mockRepository = MockUpdateMemberRepository();
    usecase = UpdateMemberUsecase(repository: mockRepository);
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

  const id = 1;

  test("should return void when member updated successful", () async {
    when(
      () => mockRepository.updateMember(id: id, entity: entity),
    ).thenAnswer((_) async => const Right(null));

    final result = await usecase.callUpdateMember(id: id, entity: entity);

    expect(result, const Right(null));
    verify(() => mockRepository.updateMember(id: id, entity: entity)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test("should return Failure when update member fails", () async {
    const tFailure = ServerFailure(message: "Erreur lors de la mise à jour.");

    when(
      () => mockRepository.updateMember(id: id, entity: entity),
    ).thenAnswer((_) async => const Left(tFailure));

    final result = await usecase.callUpdateMember(id: id, entity: entity);

    expect(result, const Left(tFailure));
    verify(() => mockRepository.updateMember(id: id, entity: entity));
  });
}
