import 'package:login_with_unite_test_and_clean_architecture/features/member/data/datasources/member_stats_datasource.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/domain/entities/member_stats_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/domain/repositories/member_stats_repository.dart';

class MemberStatsRepositoryImpl implements MemberStatsRepository {
  final MemberStatsDatasource datasource;

  const MemberStatsRepositoryImpl({required this.datasource});

  @override
  Future<MemberStatsEntity> memberStats() {
    return datasource.stats();
  }
}
