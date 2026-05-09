import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/domain/entities/member_stats_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/providers/member_stats_provider.dart';

class MemberStatsNotifier extends AsyncNotifier<MemberStatsEntity> {
  @override
  FutureOr<MemberStatsEntity> build() async {
    final usecase = ref.watch(memberStatsUsecase);
    return await usecase.call();
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }
}

final memberDataStats =
    AsyncNotifierProvider<MemberStatsNotifier, MemberStatsEntity>(
      MemberStatsNotifier.new,
    );
