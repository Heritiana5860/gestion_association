import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/domain/entities/member_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/providers/member_provider.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/providers/member_search_provider.dart';

class MemberNotifier extends AsyncNotifier<List<MemberEntity>> {
  @override
  FutureOr<List<MemberEntity>> build() async {
    final filters = ref.watch(memberFilterProvider);
    final usecase = ref.watch(memberUsecaseProvider);
    return await usecase.call(params: filters.toMap());
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }
}

final memberDataProvider =
    AsyncNotifierProvider<MemberNotifier, List<MemberEntity>>(
      MemberNotifier.new,
    );
