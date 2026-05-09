import 'package:login_with_unite_test_and_clean_architecture/features/member/domain/entities/member_stats_entity.dart';

abstract class MemberStatsRepository {
  Future<MemberStatsEntity> memberStats();
}
