import 'package:login_with_unite_test_and_clean_architecture/features/member/data/models/member_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/domain/entities/member_entity.dart';

abstract class MemberRepository {
  Future<List<MemberEntity>> members();
  Future<void> addMember({required MemberModel model});
}
