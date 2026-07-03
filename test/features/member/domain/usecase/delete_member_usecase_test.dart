import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/domain/repositories/member_repository.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/domain/usecases/delete_member_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockDeleteMemberRepository extends Mock implements MemberRepository {}

void main() {
  late MockDeleteMemberRepository mockRepository;
  late DeleteMemberUsecase usecase;

  setUp(() {
    mockRepository = MockDeleteMemberRepository();
    usecase = DeleteMemberUsecase(repository: mockRepository);
  });

  const id = 1;

  test("should return void when member deleted successful", () async {
    when(
      () => mockRepository.deleteMember(id),
    ).thenAnswer((_) async => const Right(null));

    final result = await usecase.callDeleteMember(id: id);

    expect(result, const Right(null));
    verify(() => mockRepository.deleteMember(id)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test("should return Failure when delete member fails", () async {
    const tFailure = ServerFailure(
      message: "Erreur lors de la suppression d'un membre.",
    );

    when(
      () => mockRepository.deleteMember(id),
    ).thenAnswer((_) async => const Left(tFailure));

    final result = await usecase.callDeleteMember(id: id);

    expect(result, const Left(tFailure));
    verify(() => mockRepository.deleteMember(id));
  });
}
