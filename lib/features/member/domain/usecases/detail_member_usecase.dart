import 'package:dartz/dartz.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/domain/entities/member_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/domain/repositories/member_repository.dart';

class DetailMemberUsecase {
  final MemberRepository repository;

  const DetailMemberUsecase({required this.repository});

  Future<Either<Failure, MemberEntity>> callDetailMember({
    required int id,
    required String year,
  }) {
    return repository.detailMember(id: id, year: year);
  }
}
