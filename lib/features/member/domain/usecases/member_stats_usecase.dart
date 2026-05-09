import 'package:login_with_unite_test_and_clean_architecture/features/member/domain/entities/member_stats_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/domain/repositories/member_stats_repository.dart';

class MemberStatsUsecase {
  final MemberStatsRepository repository;

  const MemberStatsUsecase({required this.repository});

  Future<MemberStatsEntity> call() {
    return repository.memberStats();
  }
}
