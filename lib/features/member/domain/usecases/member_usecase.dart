import 'package:login_with_unite_test_and_clean_architecture/features/member/data/models/member_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/domain/entities/member_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/domain/repositories/member_repository.dart';

class MemberUsecase {
  final MemberRepository repository;
  const MemberUsecase({required this.repository});

  Future<List<MemberEntity>> call() {
    return repository.members();
  }

  Future<void> callAddMember({required MemberModel model}) {
    return repository.addMember(model: model);
  }
}
