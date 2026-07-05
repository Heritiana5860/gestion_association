import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/domain/entities/president_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/presentation/providers/president/get_president_provider.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/rad/presentation/providers/president/president_provider.dart';

class PresidentNotifier extends AsyncNotifier<void> {
  @override
  FutureOr<dynamic> build() {}

  Future<void> addPresident(PresidentEntity entity) async {
    state = AsyncLoading();

    final usecase = ref.read(usecaseAddPresidentProvider);
    final result = await usecase.call(entity);

    result.fold((l) => state = AsyncError(l, StackTrace.current), (r) async {
      state = AsyncData(r);
      await ref.read(getPresidentProvider.notifier).refresh();
    });
  }

  Future<void> updatePresident({
    required int id,
    required PresidentEntity entity,
  }) async {
    state = AsyncLoading();

    final usecase = ref.read(usecaseUpdatePresidentProvider);
    final result = await usecase.callPresidentUpdate(id: id, entity: entity);

    result.fold((l) => state = AsyncError(l, StackTrace.current), (r) async {
      state = AsyncData(r);
      await ref.read(getPresidentProvider.notifier).refresh();
    });
  }
}

final presidenProvider = AsyncNotifierProvider<PresidentNotifier, void>(
  PresidentNotifier.new,
);
