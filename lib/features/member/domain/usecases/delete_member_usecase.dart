import 'package:dartz/dartz.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/domain/repositories/member_repository.dart';

class DeleteMemberUsecase {
  final MemberRepository repository;

  const DeleteMemberUsecase({required this.repository});

  Future<Either<Failure, void>> callDeleteMember({required int id}) {
    return repository.deleteMember(id);
  }
}
