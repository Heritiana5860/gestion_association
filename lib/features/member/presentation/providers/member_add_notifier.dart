import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/domain/entities/member_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/providers/member_notifier.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/providers/member_provider.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/providers/member_stats_notifier.dart';

class MemberAddNotifier extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> addMember({required MemberEntity entity}) async {
    state = AsyncLoading();

    final usecase = ref.read(memberUsecaseProvider);
    final result = await usecase.callAddMember(entity: entity);

    result.fold(
      (l) => state = AsyncError(l, StackTrace.current),
      (r) => state = AsyncValue.data(r),
    );

    if (state is! AsyncError) {
      await ref.read(memberDataProvider.notifier).refresh();
      await ref.read(memberDataStats.notifier).refresh();
    }
  }

  Future<void> updateMember({
    required int id,
    required MemberEntity entity,
  }) async {
    state = AsyncLoading();

    final usecase = ref.read(memberUsecaseProvider);
    final result = await usecase.callUpdateMember(id: id, entity: entity);

    result.fold((l) => state = AsyncError(l, StackTrace.current), (r) async {
      await Future.wait([]);

      state = AsyncData(r);
    });
  }
}

final newMemberProvider = AsyncNotifierProvider<MemberAddNotifier, void>(
  MemberAddNotifier.new,
);
