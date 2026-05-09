import 'package:login_with_unite_test_and_clean_architecture/features/member/data/datasources/member_datasource.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/data/models/member_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/domain/entities/member_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/domain/repositories/member_repository.dart';

class MemberRepositoryImpl implements MemberRepository {
  final MemberDatasource datasource;

  const MemberRepositoryImpl({required this.datasource});

  @override
  Future<List<MemberEntity>> members() async {
    return await datasource.fetchMembers();
  }

  @override
  Future<void> addMember({required MemberModel model}) async {
    return await datasource.add(model: model);
  }
}
