import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/data/models/member_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/providers/member_notifier.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/providers/member_provider.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/providers/member_stats_notifier.dart';

class MemberAddNotifier extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> addMember({required MemberModel model}) async {
    final usecase = ref.read(memberUsecaseProvider);
    state = AsyncLoading();

    state = await AsyncValue.guard(() => usecase.callAddMember(model: model));

    if (state is! AsyncError) {
      ref.read(memberDataProvider.notifier).refresh();
      ref.read(memberDataStats.notifier).refresh();
    }
  }

  Future<void> updateMember({
    required int id,
    required MemberModel model,
  }) async {
    final usecase = ref.read(memberUsecaseProvider);
    state = AsyncLoading();

    state = await AsyncValue.guard(
      () => usecase.callUpdateMember(id: id, model: model),
    );

    if (state is! AsyncError) {
      await ref.read(memberDataProvider.notifier).refresh();
      ref.read(memberDataStats.notifier).refresh();
    }
  }
}

final newMemberProvider = AsyncNotifierProvider<MemberAddNotifier, void>(
  MemberAddNotifier.new,
);
