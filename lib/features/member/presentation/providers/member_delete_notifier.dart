// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/providers/member_provider.dart';

// final deleteMemberProvider = FutureProvider.family<void, int>((ref, id) async {
//   final usecase = ref.read(deleteMemberUsecaseProvider);
//   final result = await usecase.callDeleteMember(id: id);

//   return result.fold((l) => throw l, (r) => r);
// });

import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/providers/member_provider.dart';

class MemberDeleteNotifier extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> deleteMember(int id) async {
    state = const AsyncLoading();

    final usecase = ref.read(deleteMemberUsecaseProvider);
    final result = await usecase.callDeleteMember(id: id);

    state = result.fold(
      (l) => AsyncError(l, StackTrace.current),
      (r) => const AsyncData(null),
    );
  }
}

final memberDeleteProvider = AsyncNotifierProvider<MemberDeleteNotifier, void>(
  MemberDeleteNotifier.new,
);
