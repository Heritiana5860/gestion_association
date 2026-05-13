import 'package:login_with_unite_test_and_clean_architecture/features/member/data/datasources/member_datasource.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/data/models/member_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/domain/entities/member_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/domain/repositories/member_repository.dart';

class MemberRepositoryImpl implements MemberRepository {
  final MemberDatasource datasource;

  const MemberRepositoryImpl({required this.datasource});

  @override
  Future<List<MemberEntity>> members({Map<String, dynamic>? params}) async {
    return await datasource.fetchMembers(params: params);
  }

  @override
  Future<void> addMember({required MemberModel model}) async {
    await datasource.add(model: model);
  }

  @override
  Future<void> updateMember({
    required int id,
    required MemberModel model,
  }) async {
    await datasource.update(id: id, model: model);
  }
}
