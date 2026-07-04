import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/presentation/providers/cotisation/cotisation_notifier.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/presentation/providers/stats/cotisation_stats_notifier.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/domain/entities/member_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/providers/member_notifier.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/providers/member_provider.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/providers/member_stats_notifier.dart';

class MemberAddNotifier extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> addMember({required MemberEntity entity}) async {
    state = AsyncLoading();

    final usecase = ref.read(addMemberUsecaseProvider);
    final result = await usecase.callAddMember(entity: entity);

    result.fold((l) => state = AsyncError(l, StackTrace.current), (r) async {
      state = AsyncData(r);
      await Future.wait([
        ref.read(memberDataProvider.notifier).refresh(),
        ref.read(cotisationDataProvider.notifier).refresh(),
        ref.read(memberDataStats.notifier).refresh(),
        ref.read(cotisationStats.notifier).refresh(),
      ]);
    });

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

    final usecase = ref.read(updateMemberUsecaseProvider);
    final result = await usecase.callUpdateMember(id: id, entity: entity);

    result.fold((l) => state = AsyncError(l, StackTrace.current), (r) async {
      state = AsyncData(r);

      await ref.read(memberDataProvider.notifier).refresh();

      // await Future.wait([
      //   ref.read(memberDataProvider.notifier).refresh(),
      //   ref.read(cotisationDataProvider.notifier).refresh(),
      //   ref.read(memberDataStats.notifier).refresh(),
      //   ref.read(cotisationStats.notifier).refresh(),
      // ]);
    });
  }
}

final newMemberProvider = AsyncNotifierProvider<MemberAddNotifier, void>(
  MemberAddNotifier.new,
);
