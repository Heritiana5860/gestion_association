import 'package:dartz/dartz.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/domain/entities/member_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/domain/repositories/member_repository.dart';

class AddMemberUsecase {
  final MemberRepository repository;

  const AddMemberUsecase({required this.repository});

  Future<Either<Failure, void>> callAddMember({required MemberEntity entity}) {
    return repository.addMember(entity);
  }
}
