import 'package:dartz/dartz.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/data/models/member_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/domain/entities/member_entity.dart';

abstract class MemberRepository {
  Future<Either<Failure, List<MemberEntity>>> members({
    Map<String, dynamic>? params,
    required String year,
  });
  Future<Either<Failure, void>> addMember({required MemberModel model});
  Future<Either<Failure, void>> updateMember({
    required int id,
    required MemberModel model,
  });
  Future<Either<Failure, MemberEntity>> detailMember({required int id, required String year,});
  Future<Either<Failure, void>> deleteMember({required int id});
}
