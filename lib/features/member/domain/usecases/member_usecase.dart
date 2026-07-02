import 'package:dartz/dartz.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/domain/entities/member_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/domain/repositories/member_repository.dart';

class MemberUsecase {
  final MemberRepository repository;
  const MemberUsecase({required this.repository});

  Future<Either<Failure, List<MemberEntity>>> call({
    Map<String, dynamic>? params,
    required String year,
  }) {
    return repository.members(params: params, year: year);
  }

  Future<Either<Failure, void>> callAddMember({required MemberEntity entity}) {
    return repository.addMember(entity);
  }

  Future<Either<Failure, void>> callUpdateMember({
    required int id,
    required MemberEntity entity,
  }) {
    return repository.updateMember(id: id, entity: entity);
  }

  Future<Either<Failure, MemberEntity>> callDetailMember({
    required int id,
    required String year,
  }) {
    return repository.detailMember(id: id, year: year);
  }

  Future<Either<Failure, void>> callDeleteMember({required int id}) {
    return repository.deleteMember(id);
  }
}
