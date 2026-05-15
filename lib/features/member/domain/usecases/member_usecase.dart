import 'package:login_with_unite_test_and_clean_architecture/features/member/data/models/member_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/domain/entities/member_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/domain/repositories/member_repository.dart';

class MemberUsecase {
  final MemberRepository repository;
  const MemberUsecase({required this.repository});

  Future<List<MemberEntity>> call({Map<String, dynamic>? params}) {
    return repository.members(params: params);
  }

  Future<void> callAddMember({required MemberModel model}) {
    return repository.addMember(model: model);
  }

  Future<void> callUpdateMember({required int id, required MemberModel model}) {
    return repository.updateMember(id: id, model: model);
  }

  Future<MemberEntity> callDetailMember({required int id}) {
    return repository.detailMember(id: id);
  }

  Future<void> callDeleteMember({required int id}) {
    return repository.deleteMember(id: id);
  }
}
