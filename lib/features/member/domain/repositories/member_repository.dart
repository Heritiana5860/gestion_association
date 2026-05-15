import 'package:login_with_unite_test_and_clean_architecture/features/member/data/models/member_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/domain/entities/member_entity.dart';

abstract class MemberRepository {
  Future<List<MemberEntity>> members({Map<String, dynamic>? params});
  Future<void> addMember({required MemberModel model});
  Future<void> updateMember({required int id, required MemberModel model});
  Future<MemberEntity> detailMember({required int id});
  Future<void> deleteMember({required int id});
}
