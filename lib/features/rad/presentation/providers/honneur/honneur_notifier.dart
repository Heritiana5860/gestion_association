import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/entities/honneur_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/presentation/providers/honneur/honneur_provider.dart';

class HonneurNotifier extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> createHonneur(HonneurEntity entity) async {
    state = AsyncLoading();

    final usecase = ref.read(usecaseHonneurProvider);
    final result = await usecase.call(entity: entity);

    result.fold(
      (l) => state = AsyncError(l, StackTrace.current),
      (r) => state = AsyncData(r),
    );
  }

  Future<void> honneurUpdateProvider({
    required int id,
    required HonneurEntity entity,
  }) async {
    state = AsyncLoading();

    final usecase = ref.read(usecaseHonneurProvider);
    final result = await usecase.callUpdateHonneur(id: id, entity: entity);

    result.fold(
      (l) => state = AsyncError(l, StackTrace.current),
      (r) => state = AsyncData(r),
    );
  }
}

final honneurProvider = AsyncNotifierProvider<HonneurNotifier, void>(
  HonneurNotifier.new,
);
